import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Account information set, handles all data related to an account object stored in security database.
final class Account extends EntityBase<Account> {
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

  /// [Account.vendors] property key.
  static const String kVendors = 'vendors';

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

  /// [Vendor]s related to this accounts.
  List<Vendor> vendors = <Vendor>[];

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

    List<DataMap> vendorsMaps = encode.getList(kVendors);
    if (vendorsMaps.isNotEmpty) {
      vendors = vendorsMaps.map<Vendor>(
        (DataMap e) {
          Vendor vendor = Vendor();
          vendor.decode(e);
          return vendor;
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
          kVendors: vendors
          .map(
            (Vendor e) => e.encode(),
          )
          .toList(),
      },
    );
  }

  @override
   List<EntityErrors<Account>> evaluate(List<EntityErrors<Account>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Account>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }

    if (user.trim().isEmpty || user.length > 50) {
      errors.add(
        EntityErrors<Account>(
          this,
          PropertyInfo(kUser, String, user),
          'User name length must be between 1 and 50 characters.',
          '51 > length > 0',
        ),
      );
    }
    
    errors.validateDependency(this, contact);

    if (permits.isNotEmpty) {
      for (Permit permit in permits) {
        errors.validateDependency(this, permit);
      }
    }

    if (profiles.isNotEmpty) {
      for (Profile profile in profiles) {
        errors.validateDependency(this, profile);
      }
    }

    if (vendors.isNotEmpty) {
      for (Vendor vendor in vendors) {
        errors.validateDependency(this, vendor);
      }
    }

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Account ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> contactDiff = contact.compare(ref.contact);


    if (user != ref.user) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kUser, String, user),
          user,
          ref.user,
          null,
        ),
      );
    }

    if (wildcard != ref.wildcard) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kWildcard, bool, wildcard),
          wildcard,
          ref.wildcard,
          null,
        ),
      );
    }
    
    if (contactDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kContact, Contact, contact),
          contact,
          ref.contact,
          contactDiff,
        ),
      );
    }

    for(Permit permit in permits){
      Permit? refPermit = ref.permits.firstWhere((Permit e) => e.id == permit.id, orElse: () => Permit());
      List<ObjectDifference> permitDiff = permit.compare(refPermit);

      if (permitDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kPermits, Permit, permit),
            permit,
            refPermit,
            permitDiff,
          ),
        );
      }
    }

    for(Profile profile in profiles){
      Profile? refProfile = ref.profiles.firstWhere((Profile e) => e.id == profile.id, orElse: () => Profile());
      List<ObjectDifference> profilediff = profile.compare(refProfile);

      if (profilediff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kProfiles, Profile, profile),
            profile,
            refProfile,
            profilediff,
          ),
        );
      }
    }
  
    for (Vendor vendor in vendors) {
      Vendor? refVendor = ref.vendors.firstWhere((Vendor e) => e.id == vendor.id, orElse: () => Vendor());
      List<ObjectDifference> vendorDiff = vendor.compare(refVendor);

      if (vendorDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kVendors, Vendor, vendor),
            vendor,
            refVendor,
            vendorDiff,
          ),
        );
      }
    }

    return aggregated;
  }
}