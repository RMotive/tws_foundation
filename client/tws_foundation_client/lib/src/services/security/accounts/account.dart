import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/security/contacts/contact.dart';

/// Account information set, handles all data related to an account object stored in security database.
final class Account extends EntityB<Account> {
  /// [user] property key.
  static const String kUser = "user";

  /// [contact] property key.
  static const String kContact = 'contact';

  /// [contactNavigation] property key.
  static const String kContactNavigation = 'ContactNavigation'; 

  /// Foreign relation [contactNavigation] pointer.
  int contact = 0;

  /// User identification.
  String user = "";

  /// Foreign relation [contactNavigation] record entity.
  Contact? contactNavigation;

  /// Creates a new [Account] object with the required properties.
  Account();

  @override
  DataMap encode([DataMap? entityObject]) {
    final Map<String, dynamic>? contactNavEncode = contactNavigation?.encode();

    return super.encode(
      <String, Object?>{
        kContact: contact,
        kUser: user,
        kContactNavigation: contactNavEncode,
      }
    );
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    contact = encode.get(kContact);
    user = encode.get(kUser);
    Contact? contactNavigation;
    if (encode[kContactNavigation] != null) {
      DataMap rawNavigation = encode.get(kContactNavigation, <String, dynamic>{});
      contactNavigation = Contact();
      contactNavigation.decode(rawNavigation);
    }
  }

  @override
  List<EntityInvalidation<Account>> evaluate() {
    List<EntityInvalidation<Account>> results = <EntityInvalidation<Account>>[];
    return results;
  }
  
  
}
