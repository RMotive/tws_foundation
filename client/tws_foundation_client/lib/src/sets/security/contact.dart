import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';

/// Contact information set, handles information related to a person that uses an account to authenticate its usage.
final class Contact implements CSMSetInterface {
  /// [name] property key.
  static const String kName = 'name';

  /// [lastName] property key.
  static const String kLastName = 'lastName';

  /// [email] property key.
  static const String kEmail = 'email';

  /// [phone] property key.
  static const String kPhone = 'phone';
  
  /// Private timestamp property.
  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Record database pointer.
  @override
  int id = 0;

  /// Contact name.
  String name = '';

  /// Contact last name.
  String lastName = '';

  /// Contact email.
  String email = '';

  /// Contact phone.
  String phone = '';

  /// Creates a new [Contact] object with the required properties
  Contact(this.id, this.name, this.lastName, this.email, this.phone, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates a new [Contact] object with default properties.
  Contact.a();

  /// Creates a new [Contact] object based on a [json] object.
  factory Contact.des(JObject json) {
    int id = json.get(SCK.kId);
    String name = json.get(kName);
    String lastname = json.get(kLastName);
    String email = json.get(kEmail);
    String phone = json.get(kPhone);
    DateTime timestamp = json.get(SCK.kTimestamp);

    return Contact(id, name, lastname, email, phone, timestamp: timestamp);
  }

  /// Creates a new [Contact] object overriding the given properties.
  Contact clone({
    int? id,
    String? name,
    String? lastName,
    String? email,
    String? phone,
  }) =>
      Contact(
        id ?? this.id,
        name ?? this.name,
        lastName ?? this.lastName,
        email ?? this.email,
        phone ?? this.phone,
      );

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kName: name,
      kLastName: lastName,
      kEmail: email,
      kPhone: phone,
      SCK.kTimestamp: timestamp.toIso8601String(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.trim().isEmpty) results.add(CSMSetValidationResult(kName , 'Name length must be between 1 and 50 characters.', 'strictLength(1, 50)'));
    if(lastName.trim().isEmpty) results.add(CSMSetValidationResult(kLastName , 'Last Name length must be between 1 and 50 characters.', 'strictLength(1, 50)'));
    if(email.trim().isEmpty) results.add(CSMSetValidationResult(kEmail , 'Email length must be between 1 and 30 characters.', 'strictLength(1, 30)'));
    if(phone.trim().isEmpty) results.add(CSMSetValidationResult(kPhone , 'Phone number length must be between 10 and 14 characters.', 'strictLength(10, 14)'));

    return results;
  }
}
