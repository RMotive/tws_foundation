import 'package:csm_client/csm_client.dart';

/// Contact information set, handles information related to a person that uses an account to authenticate its usage.
final class Contact extends EntityB<Contact> {
  /// [name] property key.
  static const String kName = 'name';

  /// [lastName] property key.
  static const String kLastName = 'lastName';

  /// [email] property key.
  static const String kEmail = 'email';

  /// [phone] property key.
  static const String kPhone = 'phone';

  /// Contact name.
  String name = '';

  /// Contact last name.
  String lastName = '';

  /// Contact email.
  String email = '';

  /// Contact phone.
  String phone = '';

  /// Creates a new [Contact] object with default properties.
  Contact();

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(<String, Object?>{
      kName: name,
      kLastName: lastName,
      kEmail: email,
      kPhone: phone,
    });
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    name = encode.get(kName);
    lastName = encode.get(kLastName);
    email = encode.get(kEmail);
    phone = encode.get(kPhone);
  }

  @override
  List<EntityInvalidation<Contact>> evaluate() {
    return <EntityInvalidation<Contact>>[];
  }
  
  
}
