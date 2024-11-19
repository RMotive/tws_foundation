import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class TrucksServiceBase extends TWSServiceBase {
  TrucksServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Truck>> view(SetViewOptions<Truck> options, String auth);

  Effect<SetBatchOut<Truck>> create(List<Truck> trucks, String auth);

  Effect<RecordUpdateOut<Truck>> update(Truck truck, String auth);
}
