import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class TrucksInventoriesServiceBase extends CSMServiceBase {
  TrucksInventoriesServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<TruckInventory>> view(SetViewOptions<TruckInventory> options, String auth);

}
