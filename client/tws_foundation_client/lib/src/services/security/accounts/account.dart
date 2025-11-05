import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Account information set, handles all data related to an account object stored in security database.
final class Account extends EntityB<Account> {
  /// [Account.user] property key.
  static const String kUser = "user";

  /// [Account.contact] property key.
  static const String kContact = 'contact';

  /// [Account.password] property key.
  static const String kPassword = 'password';

  /// [Account.wildcard] property key.
  static const String kWildcard = 'wildcard';

  /// [Account.permits] property key.
  static const String kPermits = 'permits';

  /// [Account.profiles] property key.
  static const String kProfiles = 'profiles';

  /// [Contact] information.
  Contact contact = Contact();

  /// User identification.
  String user = "";

  /// User password.
  String password = "";

  /// Wildcard permiss.
  bool wildcard = false;

  /// [Permit]s related to this accounts.
  List<Permit> permits = <Permit>[];
  
  /// [Profile]s related to this accounts.
  List<Profile> profiles = <Profile>[];

  /// Creates a new default [Account] object.
  Account();

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    contact = encode.getEntity(() => Contact(), kContact) ?? contact;
    user = encode.get(kUser);
    wildcard = encode.get(kWildcard);
    password = "";
    List<DataMap> permitsMaps = encode.getList(kPermits);
    if (permitsMaps.isNotEmpty) {
      permits = permitsMaps.map<Permit>(
        (DataMap e) {
          Permit permit = Permit();
          permit.decode(e);
          return permit;
        },
      ).toList();
    }

    List<DataMap> profilesMaps = encode.getList(kProfiles);
    if (profilesMaps.isNotEmpty) {
      profiles = profilesMaps.map<Profile>(
        (DataMap e) {
          Profile profile = Profile();
          profile.decode(e);
          return profile;
        },
      ).toList();
    }
    
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kContact: contact.encode(),
        kUser: user,
        kPassword: "", // TODO Manage account secrets
        kWildcard: wildcard,
        kPermits: permits
          .map(
            (Permit e) => e.encode(),
          )
          .toList(),
          kProfiles: profiles
          .map(
            (Profile e) => e.encode(),
          )
          .toList(),
      },
    );
  }

  @override
  List<EntityInvalidation<Account>> evaluate() {
    List<EntityInvalidation<Account>> invalidations = <EntityInvalidation<Account>>[];
    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<Account>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }

    if (user.trim().isEmpty || user.length > 50) {
      invalidations.add(
        EntityInvalidation<Account>(
          this,
          PropertyInfo(kUser, String, user),
          'User name length must be between 1 and 50 characters.',
          '51 > length > 0',
        ),
      );
    }
    
    invalidations.validateDependency(this, contact);

    if (permits.isNotEmpty) {
      for (Permit permit in permits) {
        invalidations.validateDependency(this, permit);
      }
    }

    if (profiles.isNotEmpty) {
      for (Profile profile in profiles) {
        invalidations.validateDependency(this, profile);
      }
    }

    return invalidations;
  }
}