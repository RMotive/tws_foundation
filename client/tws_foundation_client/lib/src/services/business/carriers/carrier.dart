import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Carrier] default builder.
Carrier carrierBuilder() => Carrier();

/// Defines a business entity that stores information for a [Carrier] that operates in any [Solution] 
final class Carrier extends NamedEntityBase<Carrier> {

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
  List<EntityErrors<Carrier>> evaluate(List<EntityErrors<Carrier>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Carrier>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Carrier>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          "Length: ${name.length}, cannot be empty and must be between 1 and 100 characters",
          "101 > length > 0",
        ),
      );
    }
    if (description != null && (description!.length > 200 || description!.trim().isEmpty)) {
      errors.add(
        EntityErrors<Carrier>(
          this,
          PropertyInfo(CorePropertiesConsts.description, String, description),
          "Length: ${description!.length}, must be empty or greater than 200 characters",
          "length < 200",
        ),
      );      
    }

    errors.validateDependency(this, status);
    errors.validateDependency(this, address);
    errors.validateDependency(this, approach);
    if(usdot != null) errors.validateDependency(this, usdot!);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Carrier ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> addressDiff = address.compare(ref.address);
    List<ObjectDifference> statusDiff = status.compare(ref.status);
    List<ObjectDifference> approachDiff = approach.compare(ref.approach);

    if(addressDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kAddress, Address, address),
          address,
          ref.address,
          addressDiff,
        ),
      );
    }

    if(statusDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(FoundationCommonPropertyKeys.kStatus, Status, status),
          status,
          ref.status,
          statusDiff,
        ),
      );
    }

    if(approachDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kApproach, Approach, approach),
          approach,
          ref.approach,
          approachDiff,
        ),
      );
    }
    // TODO: What if Ref.usdot is null?
    if(ref.usdot != null){
      List<ObjectDifference> usdotDiff = usdot?.compare(ref.usdot!) ?? <ObjectDifference>[];

      if(usdotDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kUsdot, Usdot, usdot),
            usdot,
            ref.usdot,
            usdotDiff,
          ),
        );
      }
    }
    
    
    return aggregated;
  }

}
