import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';
import 'package:tws_foundation_client/src/services/business/locations/location.dart';

final class Section extends NamedEntityB<Section> {
  /// [yard] property key.
  static const String kYard = "yard";

  /// [capacity] property key.
  static const String kCapacity = "capacity";

  /// [ocupancy] property key.
  static const String kOcupancy = "ocupancy";

  /// [location] property key.
  static const String kLocationNavigation = "location";

  /// Section vehicule storage capacity.
  int capacity = 0;

  /// Section vehicule ocupancy.
  int ocupancy = 0;
  
  /// [Location] Yard location entity asociate to this section.
  Location yard = Location();

  /// [Status] Section status.
  Status status = Status();

  /// Generates a new [Section] instance from mandatory values.
  Section();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kCapacity: capacity,
          kOcupancy: ocupancy,
          kYard: yard.encode(),
          EntitiesCommonProperties.kStatus: status.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    yard = Location();
    status = Status();
    capacity = encode.get(kCapacity);
    ocupancy = encode.get(kOcupancy);
    status.decode(encode.get(EntitiesCommonProperties.kStatus));
    yard.decode(encode.get(kYard));
  }

  @override
  List<EntityInvalidation<Section>> evaluate() {
    List<EntityInvalidation<Section>> results = <EntityInvalidation<Section>>[];

    if (id < BigInt.zero) results.add(EntityInvalidation<Section>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<Section>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null){
      if (description!.length > 200) results.add(EntityInvalidation<Section>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      if (description!.trim().isEmpty) results.add(EntityInvalidation<Section>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    
    results.validateDependency(this, status);
    results.validateDependency(this, yard);

    return results;
  }

}
