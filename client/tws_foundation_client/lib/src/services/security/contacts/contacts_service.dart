import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Represents a contract for a [ContactsServiceI] implementation, wich is responsible to manage operations
/// related with [Contact] entity at {Foundation Server}.
abstract interface class ContactsServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<Contact>, CreateServiceI<Contact> {
  /// Creates a new [ContactsServiceI] instance.
  ContactsServiceI(super.host, super.servicePath);

  /// Updates a [Contact] based on the [Contact.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Contact>> update(UpdateInput<Contact> input, String auth);

  /// Updates a [Contact] based on the [Contact.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<Contact> delete(Contact entity, String auth);
}

/// {abstract} class.
///
/// Represents a base behavior implementation for a [ContactsServiceI] implementation, providing shared default
/// behavior along built-in native and custom outside implementations.
abstract class ContactsServiceB extends FoundationServiceB implements ContactsServiceI {
  /// Creates a new [ContactsServiceB] instance.
  ContactsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [ContactsService], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [Contact] based operations.
final class ContactsService extends ContactsServiceB {
  /// Creates a new [YardLogsService] instance.
  ContactsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'contacts',
        );

  @override
  FoundationFutureResolver<ViewOutput<Contact>> view(ViewInput<Contact> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<Contact>>(
      await postSecure<ViewInput<Contact>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<Contact>> create(List<Contact> contacts, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<Contact>>(
      await postListSecure<Contact>(
        'create',
        contacts,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<Contact>> update(UpdateInput<Contact> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<Contact>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<Contact> delete(Contact entity, String authToken) async {
    return FoundationResponseResolver<Contact>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }
}
