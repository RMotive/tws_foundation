import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/services/security/security/authentication_input.dart';
import 'package:tws_foundation_client/src/services/security/security/security_service_base.dart';
import 'package:tws_foundation_client/src/services/security/security/server_session.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class SecurityService extends SecurityServiceBase {
  SecurityService(
    Uri host, {
    Client? client,
  }) : super(
          host,
          'Security',
          client: client,
        );

  @override
  Effect<ServerSession> authenticate(AuthenticationInput credentials) async {
    ResponseController effect = await postSecure('authenticate', credentials);
    return FoundationResponseResolver<ServerSession>(effect);
  }
}
