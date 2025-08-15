import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


/// {interface} for [VehiculeModelsServiceI].
///
/// Defines base contract for [VehiculeModelsServiceI] implementations that specifies the methods to have providing [VehiculeModel] based operations and management.
abstract interface class VehiculeModelsServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<VehiculeModel> {
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


/// {service} class.
///
/// Implements a [VehiculeModelsServiceI] for [VehiculeModel] based operations, providing final behavior operations.
final class VehiculeModelService extends VehiculeModelServiceB {
  ///
  VehiculeModelService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'vehiculeModels',
        );

  @override
  FoundationFutureResolver<ViewOutput<VehiculeModel>> view(ViewInput<VehiculeModel> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<VehiculeModel>>(
      await postSecure<ViewInput<VehiculeModel>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
