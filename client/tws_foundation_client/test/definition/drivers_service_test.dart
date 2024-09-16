import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late DriversServiceBase service;
  late SetViewOut<Driver> viewMock;
  late Driver createMock;
  late SetViewOptions options;

  setUp(
    () {
      List<MigrationViewOrderOptions> noOrderigns = <MigrationViewOrderOptions>[];
      options = SetViewOptions(null, noOrderigns, 1, 10, false);
      viewMock = SetViewOut<Driver>(<Driver>[], 1, DateTime.now(), 3, 0, 20);
      DateTime time = DateTime.now();
      createMock = Driver(0, 1, 1, 1, "Mexican", time, time, time, null, null, null, null, null, null, null, null, null, null, null);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Driver>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<Driver>('qTracer', createMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).drivers;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Driver>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: MigrationViewDecode<Driver>(DriverDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<Driver>> success) {
          passed = true;

          SetViewOut<Driver> fact = success.estela;
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
