import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [LocationsServiceI].
///
/// Defines base contract for [LocationsServiceI] implementations that specifies the methods to have providing [Location] based operations and management.
abstract interface class LocationsServiceI extends FoundationServiceB implements IService, ViewServiceI<Location>, CreateServiceI<Location> {
  /// Creates a new [LocationsServiceI] instance.
  LocationsServiceI(super.host, super.servicePath);

  /// Updates a [Location] based on the [Location.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Location>> update(UpdateInput<Location> input, String auth);

}


/// [Location] entity service base
abstract class LocationsServiceBase extends FoundationServiceB implements LocationsServiceI {
  /// Creates a new [LocationsServiceBase] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  LocationsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
/// 
/// Implements a [LocationsServiceI] for [Location] based operations, providing final behavior operations.
final class LocationsService extends LocationsServiceBase {
  ///
  LocationsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'locations',
        );

  @override
  FoundationFutureResolver<ViewOutput<Location>> view(ViewInput<Location> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Location>>(
      await postSecure<ViewInput<Location>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<Location>> create(List<Location> locations, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<Location>>(
      await postListSecure<Location>(
        'create',
        locations,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<Location>> update(UpdateInput<Location> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<Location>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }
}
