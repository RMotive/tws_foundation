import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late YardLogServiceBase service;
  late SetViewOut<YardLog> viewMock;
  late SetViewOptions<YardLog> options;
  late SetBatchOut<YardLog> createMock;
  late RecordUpdateOut<YardLog> updateMock;  
  late YardLog deleteMock;
  late List<YardLog> yardlogs;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<YardLog>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<YardLog>>[]);
      viewMock = SetViewOut<YardLog>(<YardLog>[], 1, DateTime.now(), 3, 0, 20);
      createMock = SetBatchOut<YardLog>(<YardLog>[], <SetOperationFailure<YardLog>>[], 0, 0, 0, false);
      updateMock = RecordUpdateOut<YardLog>(YardLog.a(), YardLog.a());
      deleteMock = YardLog.a();
      yardlogs = <YardLog>[
        YardLog.a(),
      ];

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<YardLog>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<SetBatchOut<YardLog>>('qTracer', createMock).encode(),
            'update' => SuccessFrame<RecordUpdateOut<YardLog>>('qTracer', updateMock).encode(),
            'delete' => SuccessFrame<YardLog>('qTracer', deleteMock).encode(),

            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).yardLogs;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<YardLog>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<YardLog>.des(json, YardLog.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<YardLog>> success) {
          passed = true;

          SetViewOut<YardLog> fact = success.estela;
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
      MainResolver<SetBatchOut<YardLog>> fact = await service.create(yardlogs, '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<YardLog>.des(json, YardLog.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<SetBatchOut<YardLog>> success) {
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
      MainResolver<RecordUpdateOut<YardLog>> fact = await service.update(YardLog.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<YardLog>.des(json, YardLog.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<YardLog>> success) {
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
      MainResolver<YardLog> fact = await service.delete(YardLog.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => YardLog.des(json),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<YardLog> success) {
          pased = true;
          expect(pased, true);
        },
      );
    },
  );

}
