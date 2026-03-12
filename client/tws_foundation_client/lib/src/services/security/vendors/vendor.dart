
import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


/// Types of vendors available in the system.
enum VendorType {
  owner,
  supplier,
  contractor,
  subcontractor,
  serviceProvider,
  consultant,
  partner,
  subtenent,
}

/// Defines a security entity that stores the data for vendors.
final class Vendor extends NamedReferencedEntityB<Vendor> {

  /// [Vendor.accounts] property key for [DataMap].
  static const String kAccounts = 'accounts';

  /// [Account]s collection related to this vendor.
  List<Account> accounts = <Account>[];
  
  /// Generates a new [Vendor] instance from mandatory values.
  Vendor();

  @override
  void decode(DataMap encode) {
    super.decode(encode);
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
        Account.kVendors: accounts.map((Account e) => e.encode()).toList(),
      },
    );
  }
  
  @override
  List<EntityErrors<Vendor>> evaluate(List<EntityErrors<Vendor>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Vendor>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Vendor>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        errors.add(
          EntityErrors<Vendor>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }
    if (reference.length != 8) {
      errors.add(
        EntityErrors<Vendor>(
          this,
          PropertyInfo(CorePropertiesConsts.reference, String, reference),
          "Reference value must contain 8 characters",
          "strictLength(8)",
        ),
      );
    }
    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Vendor ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

     if(name != ref.name) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.name, String, name),
          name,
          ref.name,
          null,
        ),
      );
    }

     if(description != ref.description) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.description, String, description),
          description,
          ref.description,
          null,
        ),
      );
    }

     if(reference != ref.reference) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.reference, String, reference),
          reference,
          ref.reference,
          null,
        ),
      );
    }

    return aggregated;
  }

}
