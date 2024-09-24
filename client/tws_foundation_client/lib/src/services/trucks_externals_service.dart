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

  @override
  Effect<MigrationTransactionResult<TruckExternal>> create(List<TruckExternal> trucks, String auth) async {
    CSMActEffect actEffect = await postList('create', trucks, auth: auth);
    return MainResolver<MigrationTransactionResult<TruckExternal>>(actEffect);
  }

  @override
  Effect<MigrationUpdateResult<TruckExternal>> update(TruckExternal truck, String auth) async {
    CSMActEffect actEffect = await post('update', truck, auth: auth);
    return MainResolver<MigrationUpdateResult<TruckExternal>>(actEffect);
  }
}
      