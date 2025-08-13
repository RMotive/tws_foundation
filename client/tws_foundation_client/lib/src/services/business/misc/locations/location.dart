import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/services/business/misc/waypoints/waypoint.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Location] default builder.
Location locationBuilder() => Location();

/// Defines a business entity that stores an specific [Address] and [Waypoint] location data for items, vehicules or buildings entities.
final class Location extends NamedEntityB<Location> {
  /// [Location.address] Property key.
  static const String kAddress = "address";

  /// [Location.waypoint] Property key.
  static const String kWaypoint = "waypoint";

  /// [Address] navigation set.
  Address address = Address();

  /// [Waypoint] navigation set.
  Waypoint? waypoint;

  /// Generates a new [Location] instance from mandatory values.
  Location();

  Location? sanitize({
    Address? address,
    Waypoint? waypoint,
    String? name,
    String? description,
  }) {
    this.address = address ?? this.address;
    this.waypoint = waypoint ?? this.waypoint;
    this.name = name.sanitizeOrFallback(this.name) ?? '';
    this.description = description.sanitizeOrFallback(this.description);
    
    if(waypoint != null && waypoint.id < BigInt.zero) {
      this.waypoint = null;
    }

    if (this.address.country.isEmpty &&
        this.name.isEmpty &&
        this.description == null &&
        this.waypoint == null &&
        this.address.id < BigInt.zero) {
      return null;
    }

    return this;
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kAddress: address.encode(),
        kWaypoint: waypoint?.encode(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);

    address = encode.getEntity(() => Address(), kAddress) ?? address;
    waypoint = encode.getEntity(() => Waypoint(), kWaypoint);

  }

  @override
  List<EntityInvalidation<Location>> evaluate() {
    List<EntityInvalidation<Location>> results =  <EntityInvalidation<Location>>[];

    if (id < BigInt.zero) {
      results.add(
        EntityInvalidation<Location>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }

    if (name.trim().isEmpty || name.length > 100) {
      results.add(
        EntityInvalidation<Location>(
          this,
          PropertyInfo(EntityKeys.name, String, name),
          "Length: ${name.length}, must be between 1 and 100 characters",
          "101 > length > 0",
        ),
      );
    }
    if (description != null && (description!.trim().isEmpty || description!.length > 200)) {
      results.add(
        EntityInvalidation<Location>(
          this,
          PropertyInfo(EntityKeys.description, String, description),
          "Length: ${description!.length}, must be empty or less than 200 characters",
          "length < 200",
        ),
      );
    }

    results.validateDependency(this, address);
    if(waypoint != null) results.validateDependency(this, waypoint!);

    return results;
  }
}
