import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';
import 'package:tws_foundation_client/src/services/business/addresses/address.dart';

final class Location extends NamedEntityB<Location> {
  /// [address] Property key.
  static const String kAddress = "address";

  /// [waypoint] Property key.
  static const String kWaypoint = "waypoint";

  /// [Address] navigation set.
  Address? address;

  /// [Waypoint] navigation set.
  // Waypoint? waypointNavigation;

  /// [Status] navigation set.
  Status? status;

  /// Generates a new [Location] instance from mandatory values.
  Location();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          EntitiesCommonProperties.kStatus: status?.encode(),
          kAddress: address?.encode(),

      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, <String, dynamic>{}));
    }  

    if(encode[kAddress] != null){
      address = Address();
      address!.decode(
          encode.get(kAddress, <String, dynamic>{}));
    }
  }

  @override
  List<EntityInvalidation<Location>> evaluate() {
    List<EntityInvalidation<Location>> results = <EntityInvalidation<Location>>[];

    if(name.isEmpty || name.length > 30) results.add(EntityInvalidation<Location>(this, PropertyInfo(EntityKeys.name, String, name), " Must be 25 max lenght and non-empty", "strictLength(1,30)"));
    if(address != null || (address != null && address!.id < BigInt.zero)) results.add(EntityInvalidation<Location>(this, PropertyInfo(kAddress, Address, address),'Pointer must be equal or greater than 0', 'pointerHandler()'));
    // if(waypoint != null || (waypoint != null && waypoint!.id < 0)) results.add(EntityInvalidation<Location>(this, PropertyInfo(kWaypoint, Waypoint, waypoint), '$kWaypoint pointer must be equal or greater than 0', 'pointerHandler()'));

    if(status != null || (status != null && status!.id < BigInt.zero)) results.add(EntityInvalidation<Location>(this, PropertyInfo(EntitiesCommonProperties.kStatus, Status, status), 'Pointer must be equal or greater than 0', 'pointerHandler()'));    
    
    return results;
  }

}
