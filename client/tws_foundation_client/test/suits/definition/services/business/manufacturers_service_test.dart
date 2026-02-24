import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_client_testing/csm_client_testing.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  final ViewOutput<Manufacturer> viewOutputMock = ViewOutput<Manufacturer>(manufacturerBuilder);

  late ManufacturersServiceI serviceMock;

  setUp(
    () {
      viewOutputMock.page = 1;
      viewOutputMock.pages = 1;

      final MockClient mockClient = TestingClientUtils.createMockClient(
        <String, IEncodable>{
          'view': viewOutputMock,
        },
      );

      serviceMock = ManufacturerService(
        Uri('', ''),
        client: mockClient,
      );
    },
  );

  test(
    '(def) [view]: correctly gets a {ViewOutput} generated.',
    () async {
      final ViewInput<Manufacturer> viewInput = ViewInput<Manufacturer>.b(1, 10);

      final FoundationResponseResolver<ViewOutput<Manufacturer>> resolver = await serviceMock.view(viewInput, '');

      final ViewOutput<Manufacturer> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(manufacturerBuilder));

      expect(viewOutputMock.page, viewOutput.page);
      expect(viewOutputMock.pages, viewOutput.pages);
      expect(viewOutputMock.entities, viewOutput.entities);
      expect(viewOutputMock.timestamp, viewOutput.timestamp);
    },
  );
}
