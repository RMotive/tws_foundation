import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late SolutionsServiceBase service;

  late SetViewOut<Solution> viewMock;
  late SetBatchOut<Solution> createMock;
  late RecordUpdateOut<Solution> updateMock;
  
  late SetViewOptions<Solution> options;
  late List<Solution> solutions;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<Solution>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<Solution>>[]);
      viewMock = SetViewOut<Solution>(<Solution>[], 1, DateTime.now(), 3, 0, 20);
      createMock = SetBatchOut<Solution>(<Solution>[], <SetOperationFailure<Solution>>[], 0, 0, 0, false);
      updateMock = RecordUpdateOut<Solution>(Solution.a(), Solution.a());
      solutions = <Solution>[
        Solution(12, 'something', 'TWS', ''),
      ];

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Solution>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<SetBatchOut<Solution>>('qTracer', createMock).encode(),
            'update' => SuccessFrame<RecordUpdateOut<Solution>>('qTracer', updateMock).encode(),
            _ => <String, dynamic>{},
          };
          
          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );

      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).solutions;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Solution>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Solution>.des(json, Solution.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<Solution>> success) {
          passed = true;

          SetViewOut<Solution> fact = success.estela;
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
      MainResolver<SetBatchOut<Solution>> fact = await service.create(solutions, '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Solution>.des(json, Solution.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<SetBatchOut<Solution>> success) {
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
      MainResolver<RecordUpdateOut<Solution>> fact = await service.update(Solution.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<Solution>.des(json, Solution.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<Solution>> success) {
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
