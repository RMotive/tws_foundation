import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_client_testing/csm_client_testing.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/security/solutions/_solutions_service.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
void main() {
  final ViewOutput<Solution> viewOutputMock = ViewOutput<Solution>(solutionBuilder);
  // final UpdateOutput<Solution> updateOutputMock = UpdateOutput<Solution>(solutionBuilder);
  // final BatchOperationOutput<Solution> createBatchOutputMock = BatchOperationOutput<Solution>(solutionBuilder);

  late SolutionsServiceI serviceMock;

  setUp(
    () {
      viewOutputMock.page = 1;
      viewOutputMock.pages = 1;

      final MockClient mockClient = TestingClientUtils.createMockClient(
        <String, IEncodable>{
          'view': viewOutputMock,
          // 'create': createBatchOutputMock,
          // 'update': updateOutputMock,
        },
      );

      serviceMock = SolutionsService(
        Uri('', ''),
        client: mockClient,
      );
    },
  );

  test(
    '(def) [view]: correctly gets a {ViewOutput} generated.',
    () async {
      final ViewInput<Solution> viewInput = ViewInput<Solution>.b(1, 10);

      final FoundationResponseResolver<ViewOutput<Solution>> resolver = await serviceMock.view(viewInput, '');

      final ViewOutput<Solution> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(solutionBuilder));

      expect(viewOutputMock.page, viewOutput.page);
      expect(viewOutputMock.pages, viewOutput.pages);
      expect(viewOutputMock.entities, viewOutput.entities);
      expect(viewOutputMock.timestamp, viewOutput.timestamp);
    },
  );

  // test(
  //   '(def) [create]: correctly gets a {Solution} created object',
  //   () async {
  //     final FoundationResponseResolver<BatchOperationOutput<Solution>> resolver = await serviceMock.create(<Solution>[], '');

  //     final BatchOperationOutput<Solution> batchOperationOutput = resolver.resolveDirect(() => BatchOperationOutput<Solution>(solutionBuilder));

  //     expect(createBatchOutputMock.successesCount, batchOperationOutput.successesCount);
  //     expect(createBatchOutputMock.failuresCount, batchOperationOutput.failuresCount);
  //     expect(createBatchOutputMock.failures, batchOperationOutput.failures);
  //     expect(createBatchOutputMock.successes, batchOperationOutput.successes);
  //   },
  // );

  // test(
  //   '(def) [update]: correctly gets an {Solution} update object.',
  //   () async {
  //     final FoundationResponseResolver<UpdateOutput<Solution>> resolver = await serviceMock.update(
  //       UpdateInput<Solution>(
  //         Solution(),
  //       ),
  //       '',
  //     );

  //     final UpdateOutput<Solution> updateOutput = resolver.resolveDirect(() => UpdateOutput<Solution>(solutionBuilder));

  //     expect(updateOutputMock.updated.name, updateOutput.updated.name);
  //     expect(updateOutputMock.original?.name, updateOutput.original?.name);
  //   },
  // );
}
