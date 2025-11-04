
import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {implementation} class for an [EntityI].
///
///  [Entity] that stores a relation between a collection of [Permit] with an [Account].
final class Profile extends NamedEntityB<Profile> {
  
  /// [Profile.permits] property key.
  static const String kPermits = 'permits';

  /// [Profile.accounts] property key.
  static const String kAccounts = 'accounts';

  /// [Permit]s related to this profile.
  List<Permit> permits = <Permit>[];

  /// [Account]s related to this profile.
  List<Account> accounts = <Account>[];
  
  /// Creates a new [Profile] instance.
  Profile();

  @override
  void decode(DataMap encode) {
    super.decode(encode);
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

    List<DataMap> accountsMaps = encode.getList(kAccounts);
    if (accountsMaps.isNotEmpty) {
      accounts = accountsMaps.map<Account>(
        (DataMap e) {
          Account account = Account();
          account.decode(e);
          return account;
        },
      ).toList();
    }
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kPermits: permits
          .map(
            (Permit e) => e.encode(),
          )
          .toList(),
        kAccounts: accounts
          .map(
            (Account e) => e.encode(),
          )
          .toList(),
      },
    );
  }

  @override
  List<EntityInvalidation<Profile>> evaluate() {
    List<EntityInvalidation<Profile>> invalidations = <EntityInvalidation<Profile>>[];
    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<Profile>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    
    if (name.trim().isEmpty || name.length > 100) {
      invalidations.add(
        EntityInvalidation<Profile>(
          this,
          PropertyInfo(EntityKeys.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }

    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        invalidations.add(
          EntityInvalidation<Profile>(
            this,
            PropertyInfo(EntityKeys.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }

    if (permits.isNotEmpty) {
      for (Permit permit in permits) {
        invalidations.validateDependency(this, permit);
      }
    }

    if (accounts.isNotEmpty) {
      for (Account account in accounts) {
        invalidations.validateDependency(this, account);
      }
    }

    return invalidations;
  }
}
