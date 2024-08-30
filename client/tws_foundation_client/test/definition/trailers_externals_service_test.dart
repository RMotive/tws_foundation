import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late TrailersExternalsServiceBase service;
  late MigrationView<TrailerExternal> viewMock;
  late TrailerExternal createMock;
  late MigrationViewOptions options;

  setUp(
    () {
      List<MigrationViewOrderOptions> noOrderigns = <MigrationViewOrderOptions>[];
      options = MigrationViewOptions(null, noOrderigns, 1, 10, false);
      viewMock = MigrationView<TrailerExternal>(<TrailerExternal>[], 1, DateTime.now(), 3, 0, 20);
      createMock = TrailerExternal(0, 1, 1,"Carrier test", "12345678", "87654321",null, null);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<MigrationView<TrailerExternal>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<TrailerExternal>('qTracer', createMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSAdministrationSource(
        true,
        client: mockClient,
      ).trailersExternals;
    },
  );

  test(
    'View',
    () async {
      MainResolver<MigrationView<TrailerExternal>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: MigrationViewDecode<TrailerExternal>(TrailerExternalDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<MigrationView<TrailerExternal>> success) {
          passed = true;

          MigrationView<TrailerExternal> fact = success.estela;
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
