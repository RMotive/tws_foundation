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

  /// [Account.accountPermits] property key.
  static const String kAccountPermits = 'accountPermits';

  /// [Account.accountProfiles] property key.
  static const String kAccountProfiles = 'accountProfiles';

  /// [Contact] information.
  Contact contact = Contact();

  /// User identification.
  String user = "";

  /// User password.
  String password = "";

  /// Wildcard permiss.
  bool wildcard = false;

  /// Creates a new default [Account] object.
  Account();

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    contact = encode.getEntity(() => Contact(), kContact) ?? contact;
    user = encode.get(kUser);
    wildcard = encode.get(kWildcard);
    password = "";
    
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kContact: contact.encode(),
        kUser: user,
        kPassword: "", // TODO Manage account secrets
        kWildcard: wildcard,
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
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (user.trim().isEmpty || user.length > 50) {
      invalidations.add(
        EntityInvalidation<Account>(
          this,
          PropertyInfo(kUser, String, user),
          'User name length must be between 1 and 50 characters.',
          'strictLength(50)',
        ),
      );
    }
    
    invalidations.validateDependency(this, contact);

    return invalidations;
  }
}