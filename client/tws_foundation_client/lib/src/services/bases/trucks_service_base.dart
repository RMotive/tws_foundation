import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class TrucksServiceBase extends CSMServiceBase {
  TrucksServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Truck>> view(SetViewOptions<Truck> options, String auth);

  Effect<SetBatchOut<Truck>> create(List<Truck> trucks, String auth);

}
