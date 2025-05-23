import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class SCT extends EntityB<SCT> {

  /// [type] property key.
  static const String kType = "type";

  /// [number] property key.
  static const String kNumber = "number";

  /// [configuration] property key.
  static const String kConfiguration = "configuration";

/// Descriptive type of permit.
  String type = "";

  /// Identification number of permit.
  String number = "";

  /// Descriptive permit configuration.
  String configuration = "";

  /// Foregin relation [Status] object.
  Status status = Status();

  /// Generates a new [SCT] instance from mandatory values.
  SCT();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
        EntitiesCommonProperties.kStatus: status.encode(),
        kType: type,
        kNumber: number,
        kConfiguration: configuration,
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    status.decode(encode.get(EntitiesCommonProperties.kStatus));
    type = encode.get(type);
    number = encode.get(number);
    configuration = encode.get(configuration);
  }

  @override
  List<EntityInvalidation<SCT>> evaluate() {
    List<EntityInvalidation<SCT>> results = <EntityInvalidation<SCT>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<SCT>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if(type.length != 6) results.add(EntityInvalidation<SCT>(this, PropertyInfo(kType, String, type), "Type must be 6 length", "strictLength(6)"));
    if(number.length != 25) results.add(EntityInvalidation<SCT>(this, PropertyInfo(kNumber, String, number),"Number must be 25 length", "structLength(25)"));
    if(configuration.length < 6 || configuration.length > 10) results.add(EntityInvalidation<SCT>(this, PropertyInfo(kConfiguration, String, configuration), "Configuration must be between 6 and 10 length", "strictLength(6,10)"));
    
    results.validateDependency(this, status);
    return results;
  }

}
