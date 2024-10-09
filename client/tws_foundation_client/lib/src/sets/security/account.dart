import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Account information set, handles all data related to an account object stored in security database.
final class Account implements CSMSetInterface {
  /// [user] property key.
  static const String kUser = "user";

  /// [contact] property key.
  static const String kContact = 'contact';

  /// [contactNavigation] property key.
  static const String kContactNavigation = 'contactNavigation';

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreign relation [contactNavigation] pointer.
  int contact = 0;

  /// User identification.
  String user = "";

  /// Foreign relation [contactNavigation] record entity.
  Contact? contactNavigation;

  /// Creates a new [Account] object with the required properties.
  Account(this.id, this.contact, this.user, this.contactNavigation);

  /// Creates a new [Account] object with default properties.
  Account.a();

  /// Converts a [JObject] into an [Account] object.
  factory Account.des(JObject json) {
    int id = json.get(SCK.kId);
    int contact = json.get(kContact);
    String user = json.get(kUser);

    Contact? contactNavigation;
    if (json[kContactNavigation] != null) {
      JObject rawNavigation = json.getDefault(kContactNavigation, <String, dynamic>{});
      contactNavigation = Contact.des(rawNavigation);
    }

    return Account(id, contact, user, contactNavigation);
  }

  /// Creates an [Account] object cloning the current object with new overriden properties.
  ///
  /// [id] : Record database pointer.
  ///
  /// [contact] : Foreign relation [contactNavigation] pointer.
  ///
  /// [user] : User identification.
  ///
  /// [contactNavigation] : Foreign relation [contactNavigation] record entity.
  Account clone({
    int? id,
    int? contact,
    String? user,
    Contact? contactNavigation,
  }) {
    return Account(id ?? this.id, contact ?? this.contact, user ?? this.user, contactNavigation ?? this.contactNavigation);
  }

  @override
  JObject encode() {
    final Map<String, dynamic>? contactNavEncode = contactNavigation?.encode();

    return <String, dynamic>{
      SCK.kId: id,
      kContact: contact,
      kUser: user,
      kContactNavigation: contactNavEncode,
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    return results;
  }
}
