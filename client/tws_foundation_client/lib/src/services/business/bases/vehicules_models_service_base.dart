import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class VehiculesModelsServiceBase extends TWSServiceBase {
  VehiculesModelsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<VehiculeModel>> view(SetViewOptions<VehiculeModel> options, String auth);
}
