import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/models/models_module.dart';
import 'package:tws_foundation_client/src/services/bases/services_bases.module.dart';
import 'package:tws_foundation_client/src/sets/security/contact.dart';

/// [Contact] entity service base.
abstract class ContactsServiceBase extends CSMServiceBase {
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
  Effect<SetViewOut<Contact>> view(SetViewOptions<Contact> options, String auth);
}
