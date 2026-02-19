import 'package:csm_client_core/csm_client_core.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../../../utils/test_utils.dart';

void main() {
  final ViewOutput<Situation> viewOutputMock = ViewOutput<Situation>(situationBuilder);

  late SituationsServiceI serviceMock;

  setUp(
    () {
      viewOutputMock.page = 1;
      viewOutputMock.pages = 1;

      final MockClient mockClient = TestUtils.createMockClient(
        <String, IEncodable>{
          'view': viewOutputMock,
        },
      );

      serviceMock = SituationsService(
        Uri('', ''),
        client: mockClient,
      );
    },
  );

  test(
    '(def) [view]: correctly gets a {ViewOutput} generated.',
    () async {
      final ViewInput<Situation> viewInput = ViewInput<Situation>.b(1, 10);

      final FoundationResponseResolver<ViewOutput<Situation>> resolver = await serviceMock.view(viewInput, '');

      final ViewOutput<Situation> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(situationBuilder));

      expect(viewOutputMock.page, viewOutput.page);
      expect(viewOutputMock.pages, viewOutput.pages);
      expect(viewOutputMock.entities, viewOutput.entities);
      expect(viewOutputMock.timestamp, viewOutput.timestamp);
    },
  );
}
