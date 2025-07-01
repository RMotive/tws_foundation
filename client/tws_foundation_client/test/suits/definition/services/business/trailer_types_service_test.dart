import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/business/vehicules/trailer_types/trailer_types_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../../../utils/test_utils.dart';

void main() {
  final ViewOutput<TrailerType> viewOutputMock = ViewOutput<TrailerType>(trailertypeBuilder);

  late TrailerTypesServiceI serviceMock;

  setUp(
    () {
      viewOutputMock.page = 1;
      viewOutputMock.pages = 1;

      final MockClient mockClient = TestUtils.createMockClient(
        <String, EncodableI>{
          'view': viewOutputMock,
        },
      );

      serviceMock = TrailerTypesService(
        Uri('', ''),
        client: mockClient,
      );
    },
  );

  test(
    '(def) [view]: correctly gets a {ViewOutput} generated.',
    () async {
      final ViewInput<TrailerType> viewInput = ViewInput<TrailerType>.b(1, 10);

      final FoundationResponseResolver<ViewOutput<TrailerType>> resolver = await serviceMock.view(viewInput, '');

      final ViewOutput<TrailerType> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(trailertypeBuilder));

      expect(viewOutputMock.page, viewOutput.page);
      expect(viewOutputMock.pages, viewOutput.pages);
      expect(viewOutputMock.entities, viewOutput.entities);
      expect(viewOutputMock.timestamp, viewOutput.timestamp);
    },
  );
}
