import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';
import 'package:tws_foundation_client/src/services/business/addresses/address.dart';

/// [Location] default builder.
Location locationBuilder() => Location();

/// Defines a business entity that stores an specific [Address] and [Waypoint] location data for items, vehicules or buildings entities.
final class Location extends NamedEntityB<Location> {
  /// [address] Property key.
  static const String kAddress = "address";

  /// [waypoint] Property key.
  static const String kWaypoint = "waypoint";

  /// [Address] navigation set.
  Address address = Address();

  /// [Waypoint] navigation set.
  // Waypoint? waypointNavigation;

  /// [Status] navigation set.
  Status status = Status();

  /// Generates a new [Location] instance from mandatory values.
  Location();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        EntitiesCommonProperties.kStatus: status.encode(),
        kAddress: address.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status.decode(encode.get(EntitiesCommonProperties.kStatus));
    }  

    if(encode[kAddress] != null){
      address = Address();
      address.decode(encode.get(kAddress));
    }
  }

  @override
  List<EntityInvalidation<Location>> evaluate() {
    List<EntityInvalidation<Location>> results = <EntityInvalidation<Location>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Location>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<Location>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null){
      if (description!.length > 200) results.add(EntityInvalidation<Location>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      if (description!.trim().isEmpty) results.add(EntityInvalidation<Location>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    
    results.validateDependency(this, status);
    results.validateDependency(this, address);

    return results;
  }

}
