import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/services/foundation_service_b.dart';
import 'package:tws_foundation_client/src/services/security/security/authentication_input.dart';
import 'package:tws_foundation_client/src/services/security/security/server_session.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
abstract class SecurityServiceBase extends FoundationServiceB {
  SecurityServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  ///
  Effect<ServerSession> authenticate(AuthenticationInput credentials);
}
