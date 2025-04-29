import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/constants.dart';

/// Contact information set, handles information related to a person that uses an account to authenticate its usage.
final class Contact implements EntityB<Contact> {
  /// [name] property key.
  static const String kName = 'name';

  /// [lastName] property key.
  static const String kLastName = 'lastName';

  /// [email] property key.
  static const String kEmail = 'email';

  /// [phone] property key.
  static const String kPhone = 'phone';

  /// Record database pointer.
  @override
  int id = 0;

  /// Interface identifier.
  @override
  String discriminator = "";

  /// Timestamp property.
  @override
  DateTime timestamp = DateTime.now();

  /// Contact name.
  String name = '';

  /// Contact last name.
  String lastName = '';

  /// Contact email.
  String email = '';

  /// Contact phone.
  String phone = '';

  /// Creates a new [Contact] object with the required properties
  Contact(
    this.id,
    this.discriminator,
    this.timestamp,
    this.name,
    this.lastName,
    this.email,
    this.phone, 
  );

  /// Creates a new [Contact] object with default properties.
  Contact.a();

  /// Creates a new [Contact] object based on a [json] object.
  factory Contact.des(DataMap json) {
    int id = json.get(EntitiesCommonProperties.kId);
    String discriminator = json.get(EntitiesCommonProperties.kDiscriminator, "");
    DateTime timestamp = json.get(EntitiesCommonProperties.kTimestamp);
    String name = json.get(kName);
    String lastname = json.get(kLastName);
    String email = json.get(kEmail);
    String phone = json.get(kPhone);

    return Contact(
      id,
      discriminator,
      timestamp,
      name,
      lastname,
      email,
      phone,
    );
  }

  /// Creates a new [Contact] object overriding the given properties.
  Contact clone({
    int? id,
    String? discriminator,
    DateTime? timestamp,
    String? name,
    String? lastName,
    String? email,
    String? phone,
  }) =>
      Contact(
        id ?? this.id,
        discriminator ?? this.discriminator,
        timestamp ?? this.timestamp,
        name ?? this.name,
        lastName ?? this.lastName,
        email ?? this.email,
        phone ?? this.phone,
      );

  @override
  DataMap encode([DataMap? entityObject]) {
    return <String, Object?>{
      'id': id,
      kName: name,
      kLastName: lastName,
      kEmail: email,
      kPhone: phone,
      EntitiesCommonProperties.kTimestamp: timestamp.toIso8601String(),
    };
  }

  @override
  void decode(DataMap encode) {
    
  }

  @override
  List<EntityInvalidation<Contact>> evaluate() {
    return <EntityInvalidation<Contact>>[];
  }
  
  
}
