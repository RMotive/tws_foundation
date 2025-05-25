import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/business/trailer_classes/trailer_classes_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../../../utils/integration_utils.dart';

void main() {
  late TrailerClassesServiceI service;
  late String testAuthToken;

  setUp(
    () async {
      service = FoundationServer().trailerClassesService;
      testAuthToken = await IntegrationUtils.getAuthToken();
    },
  );

  test(
    '[View] correctly get a view collection of {trailer_class} entities.',
    () async {
      FoundationResponseResolver<ViewOutput<TrailerClass>> viewResolver = await service.view(
        ViewInput<TrailerClass>.b(
          10,
          1,
        ),
        testAuthToken,
      );
      ViewOutput<TrailerClass> viewOutput = viewResolver.resolveDirect(
        () => ViewOutput<TrailerClass>(
          () => TrailerClass(),
        ),
      );
      expect(viewOutput.count >= viewOutput.length, true);
      expect(viewOutput.length >= 0, true);
      expect(viewOutput.page, 1);
      expect(viewOutput.pages >= viewOutput.page, true);
      expect(viewOutput.entities.length, viewOutput.length);
    },
  );
}