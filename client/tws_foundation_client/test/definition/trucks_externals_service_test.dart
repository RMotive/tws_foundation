import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late TrucksExternalsServiceBase service;
  late SetViewOut<TruckExternal> viewMock;
  late SetViewOptions<TruckExternal> options;
  late TruckExternal deleteMock;
  late SetBatchOut<TruckExternal> createMock;
  late RecordUpdateOut<TruckExternal> updateMock;  
  late List<TruckExternal> trucks;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<TruckExternal>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<TruckExternal>>[]);
      viewMock = SetViewOut<TruckExternal>(<TruckExternal>[], 1, DateTime.now(), 3, 0, 20);
      createMock = SetBatchOut<TruckExternal>(<TruckExternal>[], <SetOperationFailure<TruckExternal>>[], 0, 0, 0, false);
      updateMock = RecordUpdateOut<TruckExternal>(TruckExternal.a(), TruckExternal.a());
      deleteMock = TruckExternal.a();
      trucks = <TruckExternal>[
        TruckExternal.a(),
      ];
      
      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<TruckExternal>>('qTracer', viewMock).encode(),
            'delete' => SuccessFrame<TruckExternal>('qTracer', deleteMock).encode(),
            'create' => SuccessFrame<SetBatchOut<TruckExternal>>('qTracer', createMock).encode(),
            'update' => SuccessFrame<RecordUpdateOut<TruckExternal>>('qTracer', updateMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).trucksExternals;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<TruckExternal>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<TruckExternal>.des(json, TruckExternal.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<TruckExternal>> success) {
          passed = true;

          SetViewOut<TruckExternal> fact = success.estela;
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
      MainResolver<SetBatchOut<TruckExternal>> fact = await service.create(trucks, '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<TruckExternal>.des(json, TruckExternal.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<SetBatchOut<TruckExternal>> success) {
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
      MainResolver<RecordUpdateOut<TruckExternal>> fact = await service.update(TruckExternal.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<TruckExternal>.des(json, TruckExternal.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<TruckExternal>> success) {
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
    'Delete',
    () async {
      MainResolver<TruckExternal> fact = await service.delete(TruckExternal.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => TruckExternal.des(json),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<TruckExternal> success) {
          pased = true;
          expect(pased, true);
        },
      );
    },
  );
}
