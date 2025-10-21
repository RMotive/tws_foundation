import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Section] default builder.
Section sectionBuilder() => Section();

/// Defines a business entity that stores a [Section] data in a yard [Location], 
/// where [Trailer] and [Truck] entities are stored, arrived and depart as part of its operations.
final class Section extends NamedEntityB<Section> {
  /// [Section.yard] property key.
  static const String kYard = "yard";

  /// [Section.capacity] property key.
  static const String kCapacity = "capacity";

  /// [Section.ocupancy] property key.
  static const String kOcupancy = "ocupancy";

  /// [Section.resource] property key.
  static const String kResource = "resource";

  /// Section vehicule storage capacity.
  int capacity = 0;

  /// Section vehicule ocupancy.
  int ocupancy = 0;

  /// [Status] Status entity asociate to this section.
  Status status = Status();

  /// [Location] Yard location entity asociate to this section.
  Location yard = Location();

  /// [Resource] for visual represantation of this section entity.
  Resource? resource;

  /// Generates a new [Section] instance from mandatory values.
  Section();

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kCapacity: capacity,
        kOcupancy: ocupancy,
        kResource: resource?.encode(),
        FoundationCommonPropertyKeys.kSCT: status.encode(),
        kYard: yard.encode(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    yard = Location();
    capacity = encode.get(kCapacity);
    ocupancy = encode.get(kOcupancy);
    resource = encode.getEntity(() => Resource(), kResource);
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kSCT) ?? Status();
    yard.decode(encode.get(kYard));
  }

  @override
  List<EntityInvalidation<Section>> evaluate() {
    List<EntityInvalidation<Section>> results = <EntityInvalidation<Section>>[];

    if (id < BigInt.zero) {
      results.add(
        EntityInvalidation<Section>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer cannot be less than 0',
          'id < 0',
        ),
      );
    }
    
    if (name.trim().isEmpty || name.length > 100) {
      results.add(
        EntityInvalidation<Section>(
          this,
          PropertyInfo(EntityKeys.name, String, name),
          "Name: ${name.length}, must be 100 max length",
          "101 > length > 0",
        ),
      );
    }

    if (description != null) {
      if (description!.length > 200) {
        results.add(
          EntityInvalidation<Section>(
            this,
            PropertyInfo(EntityKeys.description, String, description),
            "Description: ${description!.length}, must be 200 max length",
            "201 > length",
          ),
        );
      }

      if (description!.trim().isEmpty) {
        results.add(
          EntityInvalidation<Section>(
            this,
            PropertyInfo(EntityKeys.description, String, description),
            "Description is empty but not null.",
            "value > 0 || value == null",
          ),
        );
      }
    }

    if(capacity < 0) {
      results.add(
        EntityInvalidation<Section>(
          this,
          PropertyInfo(kCapacity, int, capacity),
          "Capacity: $capacity, cannot be less than 0",
          "value >= 0",
        ),
      );
    }

    results.validateDependency(this, yard);
    results.validateDependency(this, status);
    if(resource != null) results.validateDependency(this, resource!);

    return results;
  }
}
