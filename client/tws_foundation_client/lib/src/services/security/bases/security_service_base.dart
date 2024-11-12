import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class SecurityServiceBase extends TWSServiceBase {
  SecurityServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  Effect<Session> authenticate(Credentials credentials);
}
