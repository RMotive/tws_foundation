import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/bases/contacts_service_base.dart';
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
  Effect<SetViewOut<Contact>> view(SetViewOptions<Contact> options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<Contact>>(actEffect);
  }
}
