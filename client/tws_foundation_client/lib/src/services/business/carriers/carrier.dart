import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Carrier] default builder.
Carrier carrierBuilder() => Carrier();

/// Defines a business entity that stores information for a [Carrier] that operates in any [Solution] 
final class Carrier extends NamedEntityB<Carrier> {

  /// [approach] property key.
  static const String kApproach = "approach";

  /// [address] property key.
  static const String kAddress = "address";

  /// [usdot] property key.
  static const String kUsdot = "usdot";

  /// Foreign relation [Address] object.
  Address address = Address();

  /// Carrier status.
  Status status = Status();

  /// Carrier approach.
  Approach approach = Approach();

  /// [Usdot] information.
  Usdot? usdot = Usdot();

  /// Generates a new [Carrier] instance from mandatory values.
  Carrier();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kApproach: approach.encode(),
        kAddress: address.encode(),
        kUsdot: usdot?.encode(),
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    address = encode.getEntity(() => Address(), kAddress) ?? address;
    approach = encode.getEntity(() => Approach(), kApproach) ?? approach;
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;
    usdot = encode.getEntity(() => Usdot(), kUsdot);
  }

  @override
  List<EntityInvalidation<Carrier>> evaluate() {
    List<EntityInvalidation<Carrier>> results = <EntityInvalidation<Carrier>>[];
    if (id < BigInt.zero) {
      results.add(
        EntityInvalidation<Carrier>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      results.add(
        EntityInvalidation<Carrier>(
          this,
          PropertyInfo(EntityKeys.name, String, name),
          "Length: ${name.length}, cannot be empty and must be between 1 and 100 characters",
          "101 > length > 0",
        ),
      );
    }
    if (description != null && (description!.length > 200 || description!.trim().isEmpty)) {
      results.add(
        EntityInvalidation<Carrier>(
          this,
          PropertyInfo(EntityKeys.description, String, description),
          "Length: ${description!.length}, must be empty or greater than 200 characters",
          "length < 200",
        ),
      );      
    }

    results.validateDependency(this, status);
    results.validateDependency(this, address);
    results.validateDependency(this, approach);
    if(usdot != null) results.validateDependency(this, usdot!);

    return results;
  }

}
