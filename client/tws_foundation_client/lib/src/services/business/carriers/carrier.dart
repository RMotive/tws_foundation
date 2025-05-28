import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/entities/business/approach.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';
import 'package:tws_foundation_client/src/entities/business/usdot.dart';
import 'package:tws_foundation_client/src/services/business/addresses/address.dart';

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

  /// Foreign relation [Approach] object.
  Approach approach = Approach();

  /// Foreign relation [Address] object.
  Address address = Address();

  /// Foreign relation [USDOT] object.
  USDOT? usdot;
  
  /// Foregin relation [Status] object.
  Status status = Status();

  /// Generates a new [Carrier] instance from mandatory values.
  Carrier();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
        EntitiesCommonProperties.kStatus: status.encode(),
        kApproach: approach.encode(),
        kAddress: address.encode(),
        kUsdot: usdot?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);

    status.decode(encode.get(EntitiesCommonProperties.kStatus));
    approach.decode(encode.get(kApproach));
    address.decode(encode.get(kAddress));

    if (encode[kUsdot] != null) {
      usdot = USDOT();
      usdot!.decode(encode.get(kUsdot, <String, dynamic>{}));
    }
  }

  @override
  List<EntityInvalidation<Carrier>> evaluate() {
    List<EntityInvalidation<Carrier>> results = <EntityInvalidation<Carrier>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null){
      if (description!.length > 200) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      if (description!.trim().isEmpty) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    
    results.validateDependency(this, status);
    results.validateDependency(this, approach);
    results.validateDependency(this, address);
    if(usdot != null) results.validateDependency(this, usdot!);

    return results;
  }

}
