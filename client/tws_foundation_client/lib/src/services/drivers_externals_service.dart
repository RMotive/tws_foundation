import 'package:csm_foundation_services/csm_foundation_services.dart';
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
  Effect<MigrationView<DriverExternal>> view(MigrationViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<MigrationView<DriverExternal>>(actEffect);
  }
}
      