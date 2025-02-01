import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Account information set, handles all data related to an account object stored in security database.
final class Account implements CSMSetInterface {
  /// [user] property key.
  static const String kUser = "user";

  /// [contact] property key.
  static const String kContact = 'contact';

  /// [password] property key.
  static const String kPassword = 'password';

  /// [wildcard] property key.
  static const String kWildcard = 'wildcard';

  /// [contactNavigation] property key.
  static const String kContactNavigation = 'ContactNavigation';

  /// [accountPermits] property key.
  static const String kAccountPermits = 'accountPermits';

  /// [accountProfiles] property key.
  static const String kAccountProfiles = 'accountProfiles';

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

  /// User identification.
  String password = "";

  /// Wildcard permiss.
  bool wildcard = false;

  /// Foreign relation [contactNavigation] record entity.
  Contact? contactNavigation;

  /// [AccountPermit] collection.
  List<AccountPermit> accountPermits = <AccountPermit>[];

  /// [AccountProfile] collection.
  List<AccountProfile> accountProfiles = <AccountProfile>[];

  /// Creates a new [Account] object with the required properties.
  Account(
    this.id,
    this.contact,
    this.user,
    this.password,
    this.wildcard,
    this.contactNavigation,
    this.accountPermits,
    this.accountProfiles, {
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  /// Creates a new [Account] object with default properties.
  Account.a(){
    _timestamp = DateTime.now();
  }

  /// Converts a [JObject] into an [Account] object.
  factory Account.des(JObject json) {
    int id = json.get(SCK.kId);
    int contact = json.get(kContact);
    String user = json.get(kUser);
    String password = json.get(kPassword);
    DateTime timestamp = json.get(SCK.kTimestamp);
    bool wildcard = json.get(kWildcard);

    Contact? contactNavigation;
    if (json[kContactNavigation] != null) {
      JObject rawNavigation = json.getDefault(kContactNavigation, <String, dynamic>{});
      contactNavigation = Contact.des(rawNavigation);
    }

    List<AccountPermit> accountPermits = <AccountPermit>[];
    List<JObject> rawAccountPermitsArray = json.getList(kAccountPermits);
    accountPermits = rawAccountPermitsArray.map<AccountPermit>(AccountPermit.des).toList();

    List<AccountProfile> accountProfiles = <AccountProfile>[];
    List<JObject> rawAccountProfilesArray = json.getList(kAccountProfiles);
    accountProfiles = rawAccountProfilesArray.map<AccountProfile>(AccountProfile.des).toList();

    return Account(id, contact, user, password, wildcard, contactNavigation, accountPermits, accountProfiles, timestamp: timestamp);
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
    String? password,
    bool? wildcard,
    Contact? contactNavigation,
    List<AccountPermit>? accountPermits,
    List<AccountProfile>? accountProfiles,
  }) {

    if(contact == 0){
      this.contactNavigation = null;
      contactNavigation = null;
    }

    return Account(
      id ?? this.id,
      contact ?? this.contact,
      user ?? this.user,
      password ?? this.password,
      wildcard ?? this.wildcard,
      contactNavigation ?? this.contactNavigation,
      accountPermits ?? this.accountPermits,
      accountProfiles ?? this.accountProfiles,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kContact: contact,
      kUser: user,
      kPassword: password.toString(),
      kWildcard: wildcard,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kContactNavigation: contactNavigation?.encode(),
      kAccountPermits: accountPermits.map((AccountPermit i) => i.encode()).toList(),
      kAccountProfiles: accountProfiles.map((AccountProfile i) => i.encode()).toList()
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(user.trim().isEmpty || user.length > 50) results.add(CSMSetValidationResult(kUser, 'User name length must be between 1 and 50 characters.', 'pointerHandler()'));
    if(id < 0) results.add(CSMSetValidationResult(SCK.kId, 'Account pointer cannot be less than 0', 'pointerHandler()'));
    if(contact < 0) results.add(CSMSetValidationResult(kContact, 'Contact pointer cannot be less than 0', 'pointerHandler()'));
    if(contactNavigation != null) results = <CSMSetValidationResult>[...results, ...contactNavigation!.evaluate()];
    
    for(AccountPermit accountPermit in accountPermits){
      results = <CSMSetValidationResult>[...results, ...accountPermit.evaluate()];
    }
    
    for(AccountProfile accountProfile in accountProfiles){
      results = <CSMSetValidationResult>[...results, ...accountProfile.evaluate()];
    }

    return results;
  }
}
