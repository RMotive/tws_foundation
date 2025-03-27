import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Contact] entity service implementation.
final class ContactsService extends ContactsServiceBase {
  /// [ContactsService] instance constructor.
  ///
  ///
  /// [host] server host address.
  ///
  /// [client] custom network [Client] to testing/quality purposes.
  ContactsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Contacts',
          client: client,
        );

  @override
  Effect<SetViewOutput<Contact>> view(SetViewInput<Contact> input, String auth) async {
    CSMActEffect actEffect = await twsPost('view', input, auth: auth);
    return ServiceResolver<SetViewOutput<Contact>>(actEffect);
  }
}
