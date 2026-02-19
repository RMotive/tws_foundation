import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Represents a contract for a [TrucksServiceI] implementation, wich is responsible to manage operations
/// related with [TruckCommon] entity at {Foundation Server}.
abstract interface class TrucksServiceI extends FoundationServiceB implements IService, ViewServiceI<TruckCommon>, CreateServiceI<TruckCommon> {
  /// Creates a new [TrucksServiceI] instance.
  TrucksServiceI(super.host, super.servicePath);

  /// Updates a [TruckCommon] based on the [TruckCommon.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<TruckCommon>> update(UpdateInput<TruckCommon> input, String auth);

  /// Updates a [DriverCommon] based on the [DriverCommon.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<TruckCommon> delete(TruckCommon entity, String auth);
}

/// {abstract} class.
///
/// Represents a base behavior implementation for a [TrucksServiceI] implementation, providing shared default
/// behavior along built-in native and custom outside implementations.
abstract class TruckServiceB extends FoundationServiceB implements TrucksServiceI {
  /// Creates a new [TruckServiceB] instance.
  TruckServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [TruckService], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [TruckCommon] based operations.
final class TruckService extends TruckServiceB {
  /// Creates a new [DriversService] instance.
  TruckService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'trucks',
        );

  @override
  FoundationFutureResolver<ViewOutput<TruckCommon>> view(ViewInput<TruckCommon> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<TruckCommon>>(
      await postSecure<ViewInput<TruckCommon>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<TruckCommon>> create(List<TruckCommon> trucks, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<TruckCommon>>(
      await postListSecure<TruckCommon>(
        'create',
        trucks,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<TruckCommon>> update(UpdateInput<TruckCommon> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<TruckCommon>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<TruckCommon> delete(TruckCommon entity, String authToken) async {
    return FoundationResponseResolver<TruckCommon>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
