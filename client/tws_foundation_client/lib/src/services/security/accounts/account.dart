import 'package:tws_foundation_client/src/constants.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Account information set, handles all data related to an account object stored in security database.
final class Account implements EntityB<Account> {
  /// [user] property key.
  static const String kUser = "user";

  /// [contact] property key.
  static const String kContact = 'contact';

  /// [contactNavigation] property key.
  static const String kContactNavigation = 'ContactNavigation';
  
  /// Interface identifier.
  @override
  String discriminator = "";
  
  /// Record database pointer.
  @override
  int id = 0;
  
  /// Timestamp property.
  @override
  DateTime timestamp = DateTime.now();

  /// Foreign relation [contactNavigation] pointer.
  int contact = 0;

  /// User identification.
  String user = "";

  /// Foreign relation [contactNavigation] record entity.
  Contact? contactNavigation;

  /// Creates a new [Account] object with the required properties.
  Account(
    this.id,
    this.discriminator,
    this.timestamp,
    this.contact,
    this.user,
    this.contactNavigation,
  );

  /// Creates a new [Account] object with default properties.
  Account.a();

  /// Converts a [JObject] into an [Account] object.
  factory Account.des(DataMap json) {
    int id = json.get(EntitiesCommonProperties.kId);
    String discriminator = json.get(EntitiesCommonProperties.kDiscriminator, "");
    
    int contact = json.get(kContact);
    String user = json.get(kUser);
    DateTime timestamp = json.get(EntitiesCommonProperties.kTimestamp);

    Contact? contactNavigation;
    if (json[kContactNavigation] != null) {
      DataMap rawNavigation = json.get(kContactNavigation, <String, dynamic>{});
      contactNavigation = Contact.des(rawNavigation);
    }

    return Account(
      id,
      discriminator,
      timestamp,
      contact,
      user,
      contactNavigation,
    );
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
    DateTime? timestamp,
    String? discriminator,
    int? contact,
    String? user,
    Contact? contactNavigation,
  }) {
    return Account(id ?? this.id, discriminator ?? this.discriminator, timestamp ?? this.timestamp, contact ?? this.contact, user ?? this.user, contactNavigation ?? this.contactNavigation);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    final Map<String, dynamic>? contactNavEncode = contactNavigation?.encode();

    return <String, dynamic>{
      EntitiesCommonProperties.kId: id,
      kContact: contact,
      kUser: user,
      EntitiesCommonProperties.kTimestamp: timestamp.toIso8601String(),
      kContactNavigation: contactNavEncode,
    };
  }

  @override
  void decode(DataMap encode) {

  }

  @override
  List<EntityInvalidation<Account>> evaluate() {
    List<EntityInvalidation<Account>> results = <EntityInvalidation<Account>>[];
    return results;
  }
  
  
}
