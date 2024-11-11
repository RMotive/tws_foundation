import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrucksInventoriesService extends TrucksInventoriesServiceBase {
  TrucksInventoriesService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'TrucksInventories',
          client: client,
        );
        
  @override
  Effect<SetViewOut<TruckInventory>> view(SetViewOptions<TruckInventory> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<TruckInventory>>(actEffect);
  }
}
      