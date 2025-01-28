import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late DriversServiceBase service;
  late SetViewOut<Driver> viewMock;
  late SetBatchOut<Driver> createMock;
  late RecordUpdateOut<Driver> updateMock;  
  late SetViewOptions<Driver> options;
  late List<Driver> drivers;


  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<Driver>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<Driver>>[]);
      viewMock = SetViewOut<Driver>(<Driver>[], 1, DateTime.now(), 3, 0, 20);
      createMock = SetBatchOut<Driver>(<Driver>[], <SetOperationFailure<Driver>>[], 0, 0, 0, false);
      updateMock = RecordUpdateOut<Driver>(Driver.a(), Driver.a());
      drivers = <Driver>[
        Driver.a(),
      ];
      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Driver>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<SetBatchOut<Driver>>('qTracer', createMock).encode(),
            'update' => SuccessFrame<RecordUpdateOut<Driver>>('qTracer', updateMock).encode(),

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
          expect(viewMock.records, fact.records);
          expect(viewMock.creation, fact.creation);
        },
      );

      expect(passed, true, reason: 'expected the service returned a success');
    },
    timeout: Timeout.factor(5),
  );

  test(
    'Create',
    () async {
      MainResolver<SetBatchOut<Driver>> fact = await service.create(drivers, '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Driver>.des(json, Driver.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<SetBatchOut<Driver>> success) {
          pased = true;
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
      );
      expect(pased, true);
    },
  );

  test(
    'Update',
    () async {
      MainResolver<RecordUpdateOut<Driver>> fact = await service.update(Driver.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<Driver>.des(json, Driver.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<Driver>> success) {
          pased = true;
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
      );
      expect(pased, true);
    },
  );
}
