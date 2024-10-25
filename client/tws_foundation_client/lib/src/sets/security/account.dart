import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Account information set, handles all data related to an account object stored in security database.
final class Account implements CSMSetInterface {
  /// [user] property key.
  static const String kUser = "user";

  /// [contact] property key.
  static const String kContact = 'contact';

  /// [contactNavigation] property key.
  static const String kContactNavigation = 'ContactNavigation';

  /// Private timestamp property.
  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

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
  Account(this.id, this.contact, this.user, this.contactNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates a new [Account] object with default properties.
  Account.a();

  /// Converts a [JObject] into an [Account] object.
  factory Account.des(JObject json) {
    int id = json.get(SCK.kId);
    int contact = json.get(kContact);
    String user = json.get(kUser);
    DateTime timestamp = json.get(SCK.kTimestamp);


    Contact? contactNavigation;
    if (json[kContactNavigation] != null) {
      JObject rawNavigation = json.getDefault(kContactNavigation, <String, dynamic>{});
      contactNavigation = Contact.des(rawNavigation);
    }

    return Account(id, contact, user, contactNavigation, timestamp: timestamp);
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
      SCK.kTimestamp: timestamp.toIso8601String(),
      kContactNavigation: contactNavEncode,
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    return results;
  }
}
