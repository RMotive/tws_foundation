import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../test_configs.dart';

///
final class IntegrationUtils {
  ///
  static Future<String> getAuthToken() async {
    final SecurityServiceI securityService = FoundationServer(false).securityService;

    final FoundationResponseResolver<SessionData> authenticateResolver = await securityService.authenticate(TestConfigs.qualityAuth);

    final SessionData serverSession = authenticateResolver.resolveDirect(() => SessionData());

    return serverSession.token;
  }
}
