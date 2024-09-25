import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class TrucksExternalsServiceBase extends CSMServiceBase {
  TrucksExternalsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<TruckExternal>> view(SetViewOptions<TruckExternal> options, String auth);

}
