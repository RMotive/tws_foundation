import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../test_configs.dart' show TestConfigs;

///
final class IntegrationUtils {
  ///
  static Future<String> getAuthToken() async {
    final SecurityServiceI securityService = FoundationServer(false).securityService;

    final FoundationResponseResolver<ServerSession> authenticateResolver = await securityService.authenticate(TestConfigs.qualityAuth);

    final ServerSession serverSession = authenticateResolver.resolveDirect(() => ServerSession());

    return serverSession.token;
  }
}
