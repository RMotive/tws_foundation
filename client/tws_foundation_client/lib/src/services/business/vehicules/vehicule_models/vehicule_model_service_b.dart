import 'package:tws_foundation_client/src/services/business/vehicules/vehicule_models/vehicule_models_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [VehiculeModel] entity service base
abstract class VehiculeModelServiceB extends FoundationServiceB implements VehiculeModelsServiceI {
  /// Creates a new [VehiculeModelServiceB] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  VehiculeModelServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
