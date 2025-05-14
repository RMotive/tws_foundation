import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/approach.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';
import 'package:tws_foundation_client/src/entities/business/usdot.dart';
import 'package:tws_foundation_client/src/services/business/addresses/address.dart';

final class Carrier extends NamedEntityB<Carrier> {

  /// [approach] property key.
  static const String kApproach = "approach";

  /// [address] property key.
  static const String kAddress = "address";

  /// [usdot] property key.
  static const String kUsdot = "usdot";

  /// Foreign relation [Approach] object.
  Approach? approach;

  /// Foreign relation [Address] object.
  Address? address;

  /// Foreign relation [USDOT] object.
  USDOT? usdot;
  
  /// Foregin relation [Status] object.
  Status? status;

  /// Generates a new [Carrier] instance from mandatory values.
  Carrier();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
        EntitiesCommonProperties.kStatus: status?.encode(),
        kApproach: approach?.encode(),
        kAddress: address?.encode(),
        kUsdot: usdot?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, DataMap()));
    }
    if(encode[kApproach] != null){
      approach = Approach();
      approach!.decode(
          encode.get(kApproach, DataMap()));
    }
    if(encode[kAddress] != null){
      address = Address();
      address!.decode(
          encode.get(kAddress, DataMap()));
    }
    if(encode[kUsdot] != null){
      usdot = USDOT();
      usdot!.decode(
          encode.get(kUsdot, <String, dynamic>{}));
    }
  }

  @override
  List<EntityInvalidation<Carrier>> evaluate() {
    List<EntityInvalidation<Carrier>> results = <EntityInvalidation<Carrier>>[];
    if(name.length > 20) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 20 max length", "structLength(20)"));
    if(approach == null || (approach != null && approach!.id <= BigInt.zero)) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(kApproach, Approach, approach), 'Required approach object. Must be at least one approach insertion property', 'requiredInsertion()'));
    if(address == null || (address != null && address!.id <= BigInt.zero)) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(kAddress, Address, address), 'Required address object. Must be at least one address insertion property', 'requiredInsertion()'));
    if(usdot != null && usdot!.id <= BigInt.zero) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(kUsdot, USDOT, usdot), 'USDOT pointer must be equal or greater than 0', 'pointerHandler()'));

    if(usdot != null && usdot!.id <= BigInt.zero) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(kApproach, Approach, approach), 'Pointer must be equal or greater than 0', 'pointerHandler()'));
    if(address != null && address!.id <= BigInt.zero) results.add(EntityInvalidation<Carrier>(this, PropertyInfo(kAddress, Address, address), 'Pointer must be equal or greater than 0', 'pointerHandler()'));

    // if(approach != null) results = <EntityInvalidation<Carrier>>[...results, ...approach!.evaluate().cast()];
    // if(address != null) results = <EntityInvalidation<Carrier>>[...results, ...address!.evaluate().cast()]; 
    // if(usdot != null) results = <EntityInvalidation<Carrier>>[...results, ...usdot!.evaluate().cast()];

    return results;
  }

}
