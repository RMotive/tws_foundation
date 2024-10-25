import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriversService extends DriversServiceBase {
  DriversService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Drivers',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Driver>> view(SetViewOptions<Driver> options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<Driver>>(actEffect);
  }
}
      