import 'package:csm_foundation_services/csm_foundation_services.dart';
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
  Effect<MigrationView<Driver>> view(MigrationViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<MigrationView<Driver>>(actEffect);
  }
}
      