
import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Represents a contract for a [ProfilesServiceI] implementation, wich is responsible to manage operations
/// related with [Permit] entity at {Foundation Server}.
abstract interface class ProfilesServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<Profile>, CreateServiceI<Profile> {
  /// Creates a new [ProfilesServiceI] instance.
  ProfilesServiceI(super.host, super.servicePath);

  /// Updates a [Profile] based on the [Profile.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Profile>> update(UpdateInput<Profile> input, String auth);

  /// Updates a [Profile] based on the [Profile.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<Profile> delete(Profile entity, String auth);
}

/// {abstract} class.
///
/// Represents a base behavior implementation for a [ProfilesServiceI] implementation, providing shared default
/// behavior along built-in native and custom outside implementations.
abstract class ProfilesServiceB extends FoundationServiceB implements ProfilesServiceI {
  /// Creates a new [ProfilesServiceB] instance.
  ProfilesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [ProfilesService], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [Profile] based operations.
final class ProfilesService extends ProfilesServiceB {
  /// Creates a new [ProfilesService] instance.
  ProfilesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'profiles',
        );

  @override
  FoundationFutureResolver<ViewOutput<Profile>> view(ViewInput<Profile> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<Profile>>(
      await postSecure<ViewInput<Profile>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<Profile>> create(List<Profile> permits, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<Profile>>(
      await postListSecure<Profile>(
        'create',
        permits,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<Profile>> update(UpdateInput<Profile> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<Profile>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<Profile> delete(Profile entity, String authToken) async {
    return FoundationResponseResolver<Profile>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
