import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class LocationsServiceBase extends TWSServiceBase {
  LocationsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Location>> view(SetViewOptions<Location> options, String auth);

  /// Transaction to create a set view object.
  Effect<SetBatchOut<Location>> create(List<Location> locations, String auth);

  /// Transaction to update a set object.
  Effect<RecordUpdateOut<Location>> update(Location location, String auth);
}
