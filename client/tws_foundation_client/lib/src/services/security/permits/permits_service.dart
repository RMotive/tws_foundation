import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Represents a contract for a [PermitsServiceI] implementation, wich is responsible to manage operations
/// related with [Permit] entity at {Foundation Server}.
abstract interface class PermitsServiceI extends FoundationServiceB implements IService, ViewServiceI<Permit>, CreateServiceI<Permit> {
  /// Creates a new [PermitsServiceI] instance.
  PermitsServiceI(super.host, super.servicePath);

  /// Updates a [Permit] based on the [Permit.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Permit>> update(UpdateInput<Permit> input, String auth);

  /// Updates a [Permit] based on the [Permit.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<Permit> delete(Permit entity, String auth);
}

/// {abstract} class.
///
/// Represents a base behavior implementation for a [PermitsServiceI] implementation, providing shared default
/// behavior along built-in native and custom outside implementations.
abstract class PermitsServiceB extends FoundationServiceB implements PermitsServiceI {
  /// Creates a new [PermitsServiceB] instance.
  PermitsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [PermitsService], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [Permit] based operations.
final class PermitsService extends PermitsServiceB {
  /// Creates a new [PermitsService] instance.
  PermitsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'permits',
        );

  @override
  FoundationFutureResolver<ViewOutput<Permit>> view(ViewInput<Permit> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<Permit>>(
      await postSecure<ViewInput<Permit>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<Permit>> create(List<Permit> permits, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<Permit>>(
      await postListSecure<Permit>(
        'create',
        permits,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<Permit>> update(UpdateInput<Permit> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<Permit>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<Permit> delete(Permit entity, String authToken) async {
    return FoundationResponseResolver<Permit>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
