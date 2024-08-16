import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class SecurityService extends SecurityServiceBase {
  SecurityService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Security',
          client: client,
        );

  @override
  Effect<Privileges> authenticate(Credentials credentials) async {
    CSMActEffect effect = await post('authenticate', credentials);
    return MainResolver<Privileges>(effect);
  }
}
