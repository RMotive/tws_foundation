import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
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
  Location? yard;

  /// [Status] Section status.
  Status? status;

  /// Generates a new [Section] instance from mandatory values.
  Section();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kCapacity: capacity,
          kOcupancy: ocupancy,
          kYard: yard?.encode(),
          EntitiesCommonProperties.kStatus: status?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    capacity = encode.get(kCapacity);
    ocupancy = encode.get(kOcupancy);
    if (encode[EntitiesCommonProperties.kStatus] != null) {
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, <String, dynamic>{}));
    }
    if (encode[kYard] != null) {
      yard = Location();
      yard!.decode(encode.get(kYard, <String, dynamic>{}));
    }

  }

  @override
  List<EntityInvalidation<Section>> evaluate() {
    List<EntityInvalidation<Section>> results = <EntityInvalidation<Section>>[];

    if (name.trim().isEmpty) results.add(EntityInvalidation<Section>(this, PropertyInfo('Name', String, name), 'name can\'t be empty', 'notEmpty'));

    return results;
  }

}
