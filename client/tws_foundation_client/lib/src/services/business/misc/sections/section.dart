import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Section] default builder.
Section sectionBuilder() => Section();

/// Defines a business entity that stores a [Section] data in a yard [Location], 
/// where [Trailer] and [Truck] entities are stored, arrived and depart as part of its operations.
final class Section extends NamedEntityBase<Section> {
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
        FoundationCommonPropertyKeys.kStatus: status.encode(),
        kYard: yard.encode(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    yard = encode.getEntity(() => Location(), kYard) ?? Location();
    capacity = encode.get(kCapacity);
    ocupancy = encode.get(kOcupancy);
    resource = encode.getEntity(() => Resource(), kResource);
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? Status();
    yard.decode(encode.get(kYard));
  }

  @override
    List<EntityErrors<Section>> evaluate(List<EntityErrors<Section>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Section>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer cannot be less than 0',
          'id < 0',
        ),
      );
    }
    
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Section>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          "Name: ${name.length}, must be 100 max length",
          "101 > length > 0",
        ),
      );
    }

    if (description != null) {
      if (description!.length > 200) {
        errors.add(
          EntityErrors<Section>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Description: ${description!.length}, must be 200 max length",
            "201 > length",
          ),
        );
      }
    }

    if(capacity < 0) {
      errors.add(
        EntityErrors<Section>(
          this,
          PropertyInfo(kCapacity, int, capacity),
          "Capacity: $capacity, cannot be less than 0",
          "value >= 0",
        ),
      );
    }

    errors.validateDependency(this, yard);
    errors.validateDependency(this, status);
    if(resource != null) errors.validateDependency(this, resource!);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Section ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);
    List<ObjectDifference> yardDiff = yard.compare(ref.yard);
    List<ObjectDifference> statusDiff = status.compare(ref.status);
    List<ObjectDifference> resourceDiff = resource?.compare(ref.resource ?? Resource()) ?? <ObjectDifference>[];
    
    if(capacity != ref.capacity) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kCapacity, int, capacity),
          capacity,
          ref.capacity,
          null,
        ),
      );
    }

    if(ocupancy != ref.ocupancy) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kOcupancy, int, ocupancy),
          ocupancy,
          ref.ocupancy,
          null,
        ),
      );
    }

    if(yardDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kYard, YardLog, yard),
          yard,
          ref.yard,
          yardDiff,
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
    
    if(resourceDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kResource, Resource, resource),
          resource,
          ref.resource,
          resourceDiff,
        ),
      );
    }
    return aggregated;
  }
}
