import 'package:csm_client_core/csm_client_core.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../../../utils/test_utils.dart';

void main() {
  final ViewOutput<Location> viewOutputMock = ViewOutput<Location>(locationBuilder);
  final UpdateOutput<Location> updateOutputMock = UpdateOutput<Location>(locationBuilder);
  final BatchOperationOutput<Location> createBatchOutputMock = BatchOperationOutput<Location>(locationBuilder);

  late LocationsServiceI serviceMock;

  setUp(
    () {
      viewOutputMock.page = 1;
      viewOutputMock.pages = 1;

      final MockClient mockClient = TestUtils.createMockClient(
        <String, IEncodable>{
          'view': viewOutputMock,
          'create': createBatchOutputMock,
          'update': updateOutputMock,
        },
      );

      serviceMock = LocationsService(
        Uri('', ''),
        client: mockClient,
      );
    },
  );

  test(
    '(def) [view]: correctly gets a {ViewOutput} generated.',
    () async {
      final ViewInput<Location> viewInput = ViewInput<Location>.b(1, 10);

      final FoundationResponseResolver<ViewOutput<Location>> resolver = await serviceMock.view(viewInput, '');

      final ViewOutput<Location> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(locationBuilder));

      expect(viewOutputMock.page, viewOutput.page);
      expect(viewOutputMock.pages, viewOutput.pages);
      expect(viewOutputMock.entities, viewOutput.entities);
      expect(viewOutputMock.timestamp, viewOutput.timestamp);
    },
  );

  test(
    '(def) [create]: correctly gets a {Section} created object',
    () async {
      final FoundationResponseResolver<BatchOperationOutput<Location>> resolver = await serviceMock.create(<Location>[], '');

      final BatchOperationOutput<Location> batchOperationOutput = resolver.resolveDirect(() => BatchOperationOutput<Location>(locationBuilder));

      expect(createBatchOutputMock.successesCount, batchOperationOutput.successesCount);
      expect(createBatchOutputMock.failuresCount, batchOperationOutput.failuresCount);
      expect(createBatchOutputMock.failures, batchOperationOutput.failures);
      expect(createBatchOutputMock.successes, batchOperationOutput.successes);
    },
  );

  test(
    '(def) [update]: correctly gets an {Section} update object.',
    () async {
      final FoundationResponseResolver<UpdateOutput<Location>> resolver = await serviceMock.update(
        UpdateInput<Location>(
          Location(),
        ),
        '',
      );

      final UpdateOutput<Location> updateOutput = resolver.resolveDirect(() => UpdateOutput<Location>(locationBuilder));

      expect(updateOutputMock.updated.name, updateOutput.updated.name);
      expect(updateOutputMock.original?.name, updateOutput.original?.name);
    },
  );
}
