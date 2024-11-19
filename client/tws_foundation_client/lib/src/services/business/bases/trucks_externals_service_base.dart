import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class TrucksExternalsServiceBase extends TWSServiceBase {
  TrucksExternalsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<TruckExternal>> view(SetViewOptions<TruckExternal> options, String auth);

  Effect<SetBatchOut<TruckExternal>> create(List<TruckExternal> trucks, String auth);

  Effect<RecordUpdateOut<TruckExternal>> update(TruckExternal truck, String auth);
}
