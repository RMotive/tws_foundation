import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/create_service_i.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Contract for [DriversServiceI] implementations that handles service call operations based on [DriverCommon] entity.
abstract interface class DriversServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<DriverCommon>, CreateServiceI<DriverCommon> {
  /// Creates a new [DriversServiceI] instance.
  DriversServiceI(super.host, super.servicePath);

  /// Updates a [DriverCommon] based on the [DriverCommon.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<DriverCommon>> update(UpdateInput<DriverCommon> input, String auth);

  /// Updates a [DriverCommon] based on the [DriverCommon.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<DriverCommon> delete(DriverCommon entity, String auth);

}

/// {abstract} class.
///
/// Implements base behavior for [DriversServiceI] implementations providing shared resources along custom implementations.
abstract class DriversServiceB extends FoundationServiceB implements DriversServiceI {
  /// Creates a new [DriversServiceB] instance.
  DriversServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [DriversServiceI], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [DriverCommon] based operations.
final class DriversService extends DriversServiceB {
  /// Creates a new [DriversService] instance.
  DriversService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'drivers',
        );

  @override
  FoundationFutureResolver<ViewOutput<DriverCommon>> view(ViewInput<DriverCommon> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<DriverCommon>>(
      await postSecure<ViewInput<DriverCommon>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<DriverCommon>> create(List<DriverCommon> drivers, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<DriverCommon>>(
      await postListSecure<DriverCommon>(
        'create',
        drivers,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<DriverCommon>> update(UpdateInput<DriverCommon> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<DriverCommon>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<DriverCommon> delete(DriverCommon entity, String authToken) async {
    return FoundationResponseResolver<DriverCommon>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
