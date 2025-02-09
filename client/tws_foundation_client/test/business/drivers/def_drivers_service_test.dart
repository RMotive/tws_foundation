import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late DriversServiceBase service;
  late SetViewOut<Driver> viewMock;
  late Driver createMock;
  late SetViewOptions<Driver> options;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<Driver>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<Driver>>[]);
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
        decoder: (JObject json) => SetViewOut<Driver>.des(json, Driver.des),
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
          expect(viewMock.length, fact.length);
          expect(viewMock.creation, fact.creation);
        },
      );

      expect(passed, true, reason: 'expected the service returned a success');
    },
    timeout: Timeout.factor(5),
  );
}
