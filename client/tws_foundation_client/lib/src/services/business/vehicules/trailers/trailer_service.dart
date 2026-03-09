import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Represents a contract for a [TrailersServiceI] implementation, wich is responsible to manage operations
/// related with [TrailerCommon] entity at {Foundation Server}.
abstract interface class TrailersServiceI extends FoundationServiceB implements IService, IViewService<TrailerCommon, FoundationResponseResolver<ViewOutput<TrailerCommon>>>, CreateServiceI<TrailerCommon> {
  /// Creates a new [TrailersServiceI] instance.
  TrailersServiceI(super.host, super.servicePath);

  /// Updates a [TrailerCommon] based on the [TrailerCommon.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<TrailerCommon>> update(UpdateInput<TrailerCommon> input, String auth);

  /// Updates a [TrailerCommon] based on the [TrailerCommon.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<TrailerCommon> delete(TrailerCommon entity, String auth);
}

/// {abstract} class.
///
/// Represents a base behavior implementation for a [TrailersServiceI] implementation, providing shared default
/// behavior along built-in native and custom outside implementations.
abstract class TrailersServiceB extends FoundationServiceB implements TrailersServiceI {
  /// Creates a new [TrailersServiceB] instance.
  TrailersServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [TruckService], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [TrailerCommon] based operations.
final class TrailersService extends TrailersServiceB {
  /// Creates a new [DriversService] instance.
  TrailersService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'trailers',
        );

  @override
  FoundationFutureResolver<ViewOutput<TrailerCommon>> view(ViewInput<TrailerCommon> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<TrailerCommon>>(
      await postSecure<ViewInput<TrailerCommon>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<TrailerCommon>> create(List<TrailerCommon> trucks, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<TrailerCommon>>(
      await postListSecure<TrailerCommon>(
        'create',
        trucks,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<TrailerCommon>> update(UpdateInput<TrailerCommon> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<TrailerCommon>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<TrailerCommon> delete(TrailerCommon entity, String authToken) async {
    return FoundationResponseResolver<TrailerCommon>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
