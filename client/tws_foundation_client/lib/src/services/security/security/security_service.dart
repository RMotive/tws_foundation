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
    ResponseController effect = await twsPost('authenticate', credentials);
    return ServiceResolver<ServerSession>(effect);
  }
}
