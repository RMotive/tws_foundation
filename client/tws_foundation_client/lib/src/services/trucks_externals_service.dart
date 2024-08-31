import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrucksExternalsService extends TrucksExternalsServiceBase {
  TrucksExternalsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'TrucksExternals',
          client: client,
        );
        
  @override
  Effect<MigrationView<TruckExternal>> view(MigrationViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<MigrationView<TruckExternal>>(actEffect);
  }
}
      