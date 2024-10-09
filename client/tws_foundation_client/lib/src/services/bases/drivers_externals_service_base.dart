import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


abstract class DriversExternalsServiceBase extends CSMServiceBase {
  DriversExternalsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<DriverExternal>> view(SetViewOptions<DriverExternal> options, String auth);

}
