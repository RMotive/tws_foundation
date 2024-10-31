import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class CarriersService extends CarriersServiceBase {
  CarriersService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Carriers',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Carrier>> view(SetViewOptions<Carrier> options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<Carrier>>(actEffect);
  }
}
      