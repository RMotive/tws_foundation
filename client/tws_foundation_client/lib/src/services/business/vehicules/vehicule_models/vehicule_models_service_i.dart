import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [VehiculeModelsServiceI].
///
/// Defines base contract for [VehiculeModelsServiceI] implementations that specifies the methods to have providing [VehiculeModel] based operations and management.
abstract interface class VehiculeModelsServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [VehiculeModelsServiceI] instance.
  VehiculeModelsServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [VehiculeModel] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<VehiculeModel>> view(ViewInput<VehiculeModel> input, String auth);
}
