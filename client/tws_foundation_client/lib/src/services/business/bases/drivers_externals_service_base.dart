import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class DriversExternalsServiceBase extends TWSServiceBase {
  DriversExternalsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<DriverExternal>> view(SetViewOptions<DriverExternal> options, String auth);
}
