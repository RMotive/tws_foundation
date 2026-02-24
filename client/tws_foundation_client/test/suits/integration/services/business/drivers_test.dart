import 'package:csm_client_core/csm_client_core.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../../../utils/integration_utils.dart';

void main() {
  late DriversServiceI service;
  late String testAuthToken;

  setUp(
    () async {
      service = FoundationServer(false).driversService;
      testAuthToken = await IntegrationUtils.getAuthToken();
    },
  );

  test(
    '[View] correctly get a view collection of {driver_common} entities.',
    () async {
      FoundationResponseResolver<ViewOutput<DriverCommon>> viewResolver = await service.view(
        ViewInput<DriverCommon>.b(
          10,
          1,
        ),
        testAuthToken,
      );
      ViewOutput<DriverCommon> viewOutput = viewResolver.resolveDirect(
        () => ViewOutput<DriverCommon>(
          () => DriverCommon(),
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