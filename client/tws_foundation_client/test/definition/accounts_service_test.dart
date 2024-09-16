import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/bases/accounts_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late AccountsServiceBase service;
  late SetViewOut<Account> viewMock;
  late SetViewOptions options;

  setUp(
    () {
      List<MigrationViewOrderOptions> noOrderigns = <MigrationViewOrderOptions>[];
      options = SetViewOptions(null, noOrderigns, 1, 10, false);
      viewMock = SetViewOut<Account>(<Account>[], 1, DateTime.now(), 3, 0, 20);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Account>>('qTracer', viewMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).accounts;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Account>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: MigrationViewDecode<Account>(AccountDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<Account>> success) {
          passed = true;

          SetViewOut<Account> fact = success.estela;
          expect(viewMock.page, fact.page);
          expect(viewMock.pages, fact.pages);
          expect(viewMock.records, fact.records);
          expect(viewMock.creation, fact.creation);
        },
      );

      expect(passed, true, reason: 'expected the service returned a success');
    },
    timeout: Timeout.factor(5),
  );
}
