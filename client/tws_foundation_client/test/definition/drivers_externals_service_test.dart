import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late DriversExternalsServiceBase service;
  late MigrationView<DriverExternal> viewMock;
  late DriverExternal createMock;
  late MigrationViewOptions options;

  setUp(
    () {
      List<MigrationViewOrderOptions> noOrderigns = <MigrationViewOrderOptions>[];
      options = MigrationViewOptions(null, noOrderigns, 1, 10, false);
      viewMock = MigrationView<DriverExternal>(<DriverExternal>[], 1, DateTime.now(), 3, 0, 20);
      createMock = DriverExternal(0, 1, 1, 1, null, null, null);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<MigrationView<DriverExternal>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<DriverExternal>('qTracer', createMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).driversExternals;
    },
  );

  test(
    'View',
    () async {
      MainResolver<MigrationView<DriverExternal>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: MigrationViewDecode<DriverExternal>(DriverExternalDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<MigrationView<DriverExternal>> success) {
          passed = true;

          MigrationView<DriverExternal> fact = success.estela;
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
