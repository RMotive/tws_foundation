import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_client_testing/csm_client_testing.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  final ViewOutput<Section> viewOutputMock = ViewOutput<Section>(sectionBuilder);
  // final UpdateOutput<Section> updateOutputMock = UpdateOutput<Section>(sectionBuilder);
  // final BatchOperationOutput<Section> createBatchOutputMock = BatchOperationOutput<Section>(sectionBuilder);

  late SectionsServiceI serviceMock;

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

      serviceMock = SectionsService(
        Uri('', ''),
        client: mockClient,
      );
    },
  );

  test(
    '(def) [view]: correctly gets a {ViewOutput} generated.',
    () async {
      final ViewInput<Section> viewInput = ViewInput<Section>.b(1, 10);

      final FoundationResponseResolver<ViewOutput<Section>> resolver = await serviceMock.view(viewInput, '');

      final ViewOutput<Section> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(sectionBuilder));

      expect(viewOutputMock.page, viewOutput.page);
      expect(viewOutputMock.pages, viewOutput.pages);
      expect(viewOutputMock.entities, viewOutput.entities);
      expect(viewOutputMock.timestamp, viewOutput.timestamp);
    },
  );

  // test(
  //   '(def) [create]: correctly gets a {Section} created object',
  //   () async {
  //     final FoundationResponseResolver<BatchOperationOutput<Section>> resolver = await serviceMock.create(<Section>[], '');

  //     final BatchOperationOutput<Section> batchOperationOutput = resolver.resolveDirect(() => BatchOperationOutput<Section>(sectionBuilder));

  //     expect(createBatchOutputMock.successesCount, batchOperationOutput.successesCount);
  //     expect(createBatchOutputMock.failuresCount, batchOperationOutput.failuresCount);
  //     expect(createBatchOutputMock.failures, batchOperationOutput.failures);
  //     expect(createBatchOutputMock.successes, batchOperationOutput.successes);
  //   },
  // );

  // test(
  //   '(def) [update]: correctly gets an {Section} update object.',
  //   () async {
  //     final FoundationResponseResolver<UpdateOutput<Section>> resolver = await serviceMock.update(
  //       UpdateInput<Section>(
  //         Section(),
  //       ),
  //       '',
  //     );

  //     final UpdateOutput<Section> updateOutput = resolver.resolveDirect(() => UpdateOutput<Section>(sectionBuilder));

  //     expect(updateOutputMock.updated.name, updateOutput.updated.name);
  //     expect(updateOutputMock.original?.name, updateOutput.original?.name);
  //   },
  // );
}
