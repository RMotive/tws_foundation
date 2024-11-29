import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late DriversExternalsServiceBase service;
  late SetViewOut<DriverExternal> viewMock;
  late SetBatchOut<DriverExternal> createMock;
  late RecordUpdateOut<DriverExternal> updateMock;  
  late SetViewOptions<DriverExternal> options;
  late List<DriverExternal> drivers;


  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<DriverExternal>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<DriverExternal>>[]);
      viewMock = SetViewOut<DriverExternal>(<DriverExternal>[], 1, DateTime.now(), 3, 0, 20);
      createMock = SetBatchOut<DriverExternal>(<DriverExternal>[], <SetOperationFailure<DriverExternal>>[], 0, 0, 0, false);
      updateMock = RecordUpdateOut<DriverExternal>(DriverExternal.a(), DriverExternal.a());
      drivers = <DriverExternal>[
        DriverExternal.a(),
      ];
      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<DriverExternal>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<SetBatchOut<DriverExternal>>('qTracer', createMock).encode(),
             'update' => SuccessFrame<RecordUpdateOut<DriverExternal>>('qTracer', updateMock).encode(),

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
      MainResolver<SetViewOut<DriverExternal>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<DriverExternal>.des(json, DriverExternal.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<DriverExternal>> success) {
          passed = true;

          SetViewOut<DriverExternal> fact = success.estela;
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
      MainResolver<SetBatchOut<DriverExternal>> fact = await service.create(drivers, '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<DriverExternal>.des(json, DriverExternal.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<SetBatchOut<DriverExternal>> success) {
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
      MainResolver<RecordUpdateOut<DriverExternal>> fact = await service.update(DriverExternal.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<DriverExternal>.des(json, DriverExternal.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<DriverExternal>> success) {
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
