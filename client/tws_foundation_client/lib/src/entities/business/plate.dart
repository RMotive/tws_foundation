import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class Plate extends EntityB<Plate> {
  /// [identifier] property key.
  static const String kIdentifier = "identifier";

  /// [state] property key.
  static const String kState = "state";

  /// [country] property key.
  static const String kCountry = "country";

  /// [expiration] property key.
  static const String kExpiration = "expiration";

  /// [truck] property key.
  static const String kTruck = "truck";

  /// [trailer] property key.
  static const String kTrailer = "trailer";

  ///
  String identifier = "";

  String country = "";

  String? state;

  DateTime? expiration;

  /// Entity [Status] information.
  Status status = Status();

  /// Generates a new [Plate] instance from mandatory values.
  Plate();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          EntitiesCommonProperties.kStatus: status.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    status = Status();
    status.decode(encode.get(EntitiesCommonProperties.kStatus));
  }

  @override
  List<EntityInvalidation<Plate>> evaluate() {
    List<EntityInvalidation<Plate>> results = <EntityInvalidation<Plate>>[];

    if (id < BigInt.zero) results.add(EntityInvalidation<Plate>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (identifier.trim().length < 5 || identifier.length > 12) results.add(EntityInvalidation<Plate>(this, PropertyInfo(kIdentifier, String, kIdentifier), "Identifier length must be between 8 and 12", "strictLength(8,12)"));
    if (state != null){
      if (state!.length < 2 || state!.length > 4) results.add(EntityInvalidation<Plate>(this, PropertyInfo(kState, String, kState), "State length must be between 2 and 4", "strictLength(2,4)"));
    }
    if(country.length <2 || country.length > 3) results.add(EntityInvalidation<Plate>(this, PropertyInfo(kCountry, String, kCountry), "Country length must be between 2 and 3", "strictLength(2,3)"));
    
    results.validateDependency(this, status);

    return results;
  }

}
