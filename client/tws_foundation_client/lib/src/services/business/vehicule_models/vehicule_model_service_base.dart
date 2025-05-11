import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/business/vehicule_models/vehicule_model.dart';
import 'package:tws_foundation_client/src/services/foundation_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [VehiculeModel] entity service base
abstract class VehiculeModelServiceBase extends FoundationServiceB {
  /// Creates a new [VehiculeModelServiceBase] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  VehiculeModelServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  ///
  Effect<SetViewOutput<VehiculeModel>> view(SetViewInput<VehiculeModel> input, String auth);
}
