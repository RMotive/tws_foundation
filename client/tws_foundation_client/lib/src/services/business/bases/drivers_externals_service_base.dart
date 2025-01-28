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

    /// Transaction to create a set view object.
  Effect<SetBatchOut<DriverExternal>> create(List<DriverExternal> drivers, String auth);

  /// Transaction to update a set object.
  Effect<RecordUpdateOut<DriverExternal>> update(DriverExternal driver, String auth);
}

