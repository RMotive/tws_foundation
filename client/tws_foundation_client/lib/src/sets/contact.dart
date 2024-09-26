import 'package:csm_foundation_services/csm_foundation_services.dart';

final class Contact implements CSMEncodeInterface {
  static const String kTimestamp = "timestamp";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;
  
  final int id;
  final String name;
  final String lastname;
  final String email;
  final String phone;
  
  Contact(this.id, this.name, this.lastname, this.email, this.phone, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Contact.des(JObject json) {
    int id = json.get('id');
    String name = json.get('name');
    String lastname = json.get('lastname');
    String email = json.get('email');
    String phone = json.get('phone');
    DateTime timestamp = json.get('timestamp');

    return Contact(id, name, lastname, email, phone, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      kTimestamp: timestamp.toIso8601String(),
    };
  }
}

final class ContactDecoder implements CSMDecodeInterface<Contact> {
  const ContactDecoder();

  @override
  Contact decode(JObject json) {
    return Contact.des(json);
  }
}
