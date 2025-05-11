import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';
import 'package:tws_foundation_client/src/services/business/trailer_classes/trailer_class.dart';

final class TrailerType extends EntityB<TrailerType> {
  /// [size] property key.
  static const String kSize = "size";

  /// [trailerClass] property key.
  static const String ktrailerClass = "trailerClass";

  /// Trailer dimensions.
  String size = "";

  /// Foregin relation [Status] object.
  Status? status;

  /// Foregin relation [TrailerClass] object.
  TrailerClass? trailerClass;

  /// Generates a new [TrailerType] instance from mandatory values.
  TrailerType();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kSize: size,
          EntitiesCommonProperties.kStatus: status?.encode(),
          ktrailerClass: trailerClass?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    size = encode.get(kSize);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, DataMap()));
    }
    if(encode[ktrailerClass] != null){
      trailerClass = TrailerClass();
      trailerClass!.decode(
          encode.get(ktrailerClass, DataMap()));
    }
  }

  @override
  List<EntityInvalidation<TrailerType>> evaluate() {
    List<EntityInvalidation<TrailerType>> results = <EntityInvalidation<TrailerType>>[];

    if (size.trim().isEmpty) results.add(EntityInvalidation<TrailerType>(this, PropertyInfo(kSize, String, size), 'Size can\'t be empty', 'notEmpty'));
    if (size.length > 16) results.add(EntityInvalidation<TrailerType>(this, PropertyInfo(kSize, String, size), 'Size must be 16 max length', 'StrictLength(16)'));

    // if (sign.length != 5) results.add(EntityInvalidation(kSign, 'Solution sign must be 5 length', 'strictLength(5)'));
    return results;
  }

}
