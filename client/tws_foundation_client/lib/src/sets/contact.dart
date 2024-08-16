import 'package:csm_foundation_services/csm_foundation_services.dart';

final class Contact implements CSMEncodeInterface {
  final int id;
  final String name;
  final String lastname;
  final String email;
  final String phone;

  const Contact(this.id, this.name, this.lastname, this.email, this.phone);

  factory Contact.des(JObject json) {
    int id = json.get('id');
    String name = json.get('name');
    String lastname = json.get('lastname');
    String email = json.get('email');
    String phone = json.get('phone');

    return Contact(id, name, lastname, email, phone);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastname': lastname,
      'email': email,
      'phone': phone
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
