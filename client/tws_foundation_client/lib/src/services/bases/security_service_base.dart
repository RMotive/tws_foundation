import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class SecurityServiceBase extends CSMServiceBase {
  SecurityServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  Effect<Privileges> authenticate(Credentials credentials);
}
