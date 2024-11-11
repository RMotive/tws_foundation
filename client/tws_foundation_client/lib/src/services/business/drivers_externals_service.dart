import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriversExternalsService extends DriversExternalsServiceBase {
  DriversExternalsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'DriversExternals',
          client: client,
        );
        
  @override
  Effect<SetViewOut<DriverExternal>> view(SetViewOptions<DriverExternal> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<DriverExternal>>(actEffect);
  }
}
      