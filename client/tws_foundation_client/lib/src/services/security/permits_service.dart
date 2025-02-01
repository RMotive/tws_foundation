import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class PermitsService extends PermitsServiceBase {
  PermitsService(
    CSMUri host, {
    Client? client,
    CSMHeaders? headers,
  }) : super(
          host,
          'Permits',
          client: client,
          headers: headers,
        );

  @override
  Effect<SetViewOut<Permit>> view(SetViewOptions<Permit> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Permit>>(actEffect);
  }
}
