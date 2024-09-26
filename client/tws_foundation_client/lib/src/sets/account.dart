import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Account implements CSMSetInterface {
  static const String kUser = "user";
  static const String kContact = 'contact';
  static const String kTimestamp = "timestamp";
  static const String kContactNavigation = 'ContactNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int contact = 0;
  String user = "";
  Contact? contactNavigation;

  Account(this.id, this.contact, this.user, this.contactNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }
  factory Account.des(JObject json) {
    int id = json.get('id');
    int contact = json.get('contact');
    String user = json.get('user');
    DateTime timestamp = json.get('timestamp');
    Contact? contactNavigation;
    if (json['ContactNavigation'] != null) {
      JObject rawNavigation = json.getDefault('ContactNavigation', <String, dynamic>{});
      contactNavigation = deserealize<Contact>(rawNavigation, decode: ContactDecoder());
    }

    return Account(id, contact, user, contactNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kContact: contact,
      kUser: user,
      kTimestamp: timestamp.toIso8601String(),
      kContactNavigation: contactNavigation?.encode()
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
  
    return results;
  }
  Account.def();
  Account clone({
    int? id,
    int? contact,
    String? user,
    Contact? contactNavigation,
  }){
   
    return Account(id ?? this.id, contact ?? this.contact, user ?? this.user, contactNavigation ?? this.contactNavigation);
  }

}

final class AccountDecoder implements CSMDecodeInterface<Account> {
  const AccountDecoder();

  @override
  Account decode(JObject json) {
    return Account.des(json);
  }
}
