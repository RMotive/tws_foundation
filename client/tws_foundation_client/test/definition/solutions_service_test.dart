import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late SolutionsServiceBase service;

  late SetViewOut<Solution> viewMock;
  late MigrationTransactionResult<Solution> createMock;
  late MigrationUpdateResult<Solution> updateMock;
  
  late SetViewOptions options;
  late List<Solution> solutions;

  setUp(
    () {
      List<MigrationViewOrderOptions> noOrderigns = <MigrationViewOrderOptions>[];
      options = SetViewOptions(null, noOrderigns, 1, 10, false);
      viewMock = SetViewOut<Solution>(<Solution>[], 1, DateTime.now(), 3, 0, 20);
      createMock = MigrationTransactionResult<Solution>(<Solution>[], <MigrationTransactionFailure<Solution>>[], 0, 0, 0, false);
      updateMock = MigrationUpdateResult<Solution>(Solution.a(), Solution.a());
      solutions = <Solution>[
        Solution(12, 'something', 'TWS', ''),
      ];

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Solution>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<MigrationTransactionResult<Solution>>('qTracer', createMock).encode(),
            'update' => SuccessFrame<MigrationUpdateResult<Solution>>('qTracer', updateMock).encode(),
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
        decoder: MigrationViewDecode<Solution>(SolutionDecoder()),
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
      MainResolver<MigrationTransactionResult<Solution>> fact = await service.create(solutions, '');
      bool pased = false;
      fact.resolve(
        decoder: MigrationTransactionResultDecoder<Solution>(SolutionDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<MigrationTransactionResult<Solution>> success) {
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
      MainResolver<MigrationUpdateResult<Solution>> fact = await service.update(Solution.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: MigrationUpdateResultDecoder<Solution>(SolutionDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<MigrationUpdateResult<Solution>> success) {
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
