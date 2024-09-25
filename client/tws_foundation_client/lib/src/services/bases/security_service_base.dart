import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class SecurityServiceBase extends CSMServiceBase {
  SecurityServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  Effect<Privileges> authenticate(Credentials credentials);
}
