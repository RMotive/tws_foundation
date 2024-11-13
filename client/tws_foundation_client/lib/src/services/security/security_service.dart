import 'package:csm_client/csm_client.dart';
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
  Effect<Session> authenticate(Credentials credentials) async {
    CSMActEffect effect = await twsPost('authenticate', credentials);
    return MainResolver<Session>(effect);
  }
}
