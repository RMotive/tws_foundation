import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/security/contacts/contact.dart';
import 'package:tws_foundation_client/src/services/security/contacts/contacts_service_base.dart';
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
    Uri host, {
    Client? client,
  }) : super(
          host,
          'Contacts',
          client: client,
        );

  @override
  Effect<SetViewOutput<Contact>> view(SetViewInput<Contact> input, String auth) async {
    ResponseController actEffect = await postSecure('view', input, authToken: auth);
    return FoundationResponseResolver<SetViewOutput<Contact>>(actEffect);
  }
}
