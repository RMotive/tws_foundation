import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/foundation_service_b.dart';
import 'package:tws_foundation_client/src/services/security/contacts/contact.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Contact] entity service base.
abstract class ContactsServiceBase extends FoundationServiceB {
  /// [ContactsServiceBase] instance constructor.
  ///
  /// [host] server host address.
  ///
  /// [servicePath] service path address.
  ///
  /// [client] custom nwteork [Client] to testing/quality purposes.
  ContactsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// calculates a dynamic records view based on [Contact] entity records.
  ///
  /// [options] dynamic options to indicate how to calculate records to show.
  ///
  /// [auth] auth server token to grant service requests,
  Effect<SetViewOutput<Contact>> view(SetViewInput<Contact> options, String auth);
}
