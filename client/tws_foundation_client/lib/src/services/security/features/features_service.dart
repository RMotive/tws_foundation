import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Represents a contract for a [FeaturesServiceI] implementation, wich is responsible to manage operations
/// related with [Feature] entity at {Foundation Server}.
abstract interface class FeaturesServiceI extends FoundationServiceB implements IService, IViewService<Feature, FoundationResponseResolver<ViewOutput<Feature>>>, CreateServiceI<Feature> {
  /// Creates a new [FeaturesServiceI] instance.
  FeaturesServiceI(super.host, super.servicePath);

  /// Updates a [Contact] based on the [Contact.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Feature>> update(UpdateInput<Feature> input, String auth);

  /// Updates a [Contact] based on the [Contact.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<Feature> delete(Feature entity, String auth);
}

/// {abstract} class.
///
/// Represents a base behavior implementation for a [FeaturesServiceI] implementation, providing shared default
/// behavior along built-in native and custom outside implementations.
abstract class FeaturesServiceB extends FoundationServiceB implements FeaturesServiceI {
  /// Creates a new [FeaturesServiceB] instance.
  FeaturesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [FeaturesService], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [Feature] based operations.
final class FeaturesService extends FeaturesServiceB {
  /// Creates a new [FeaturesService] instance.
  FeaturesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'features',
        );

  @override
  FoundationFutureResolver<ViewOutput<Feature>> view(ViewInput<Feature> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<Feature>>(
      await postSecure<ViewInput<Feature>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<Feature>> create(List<Feature> features, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<Feature>>(
      await postListSecure<Feature>(
        'create',
        features,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<Feature>> update(UpdateInput<Feature> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<Feature>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<Feature> delete(Feature entity, String authToken) async {
    return FoundationResponseResolver<Feature>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
