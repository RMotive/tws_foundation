import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class DriversServiceBase extends TWSServiceBase {
  DriversServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Driver>> view(SetViewOptions<Driver> options, String auth);

  /// Transaction to create a set view object.
  Effect<SetBatchOut<Driver>> create(List<Driver> drivers, String auth);

  /// Transaction to update a set object.
  Effect<RecordUpdateOut<Driver>> update(Driver driver, String auth);
}
