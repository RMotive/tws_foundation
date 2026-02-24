import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/core/extensions.dart';
import 'package:tws_foundation_client/src/services/business/misc/statuses/status.dart';
import 'package:tws_foundation_client/src/services/business/vehicules/trailer_classes/trailer_class.dart';

/// [TrailerType] default builder.
TrailerType trailertypeBuilder() => TrailerType();

/// Defines a business entity that stores relevant data for a trailer operation, like [size] or [TrailerClass]. 
final class TrailerType extends EntityBase<TrailerType> {
  /// [TrailerType.size] property key.
  static const String kSize = "size";

  /// [TrailerType.trailerClass] property key.
  static const String ktrailerClass = "class";

  /// Trailer dimensions.
  /// 
  /// rules >
  /// 1. 17 > Length > 0
  String size = "";

  /// Foregin relation [TrailerClass] object.
  TrailerClass trailerClass = TrailerClass();

  /// [Status] information.
  Status status = Status();

  /// Generates a new [TrailerType] instance from mandatory values.
  TrailerType();

  /// Validate nulleable inputs to avoid [TrailerType] entities with empty values.
  TrailerType? sanitize({
    String? size,
  }){

    this.size = size.sanitizeOrFallback(this.size) ?? '';

    if(this.size.isEmpty) return null;

    return this;
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kSize: size,
        ktrailerClass: trailerClass.encode(),
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    size = encode.get(kSize);
    trailerClass = encode.getEntity(() => TrailerClass(), ktrailerClass) ?? TrailerClass();
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? Status();
  }

  @override
  List<EntityErrors<TrailerType>> evaluate(List<EntityErrors<TrailerType>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
         EntityErrors<TrailerType>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          'id < 0',
        ),
      );
    }

    if (size.trim().isEmpty || size.length > 16) {
      errors.add(
        EntityErrors<TrailerType>(
          this,
          PropertyInfo(kSize, String, size),
          'Length: $size, can\'t be empty or longer than 16.',
          '17 > Length > 0',
        ),
      );
    }

    errors.validateDependency(this, trailerClass);
    errors.validateDependency(this, status);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(TrailerType ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> trailerClassDiff = trailerClass.compare(ref.trailerClass);
    List<ObjectDifference> statusDiff = status.compare(ref.status);

    if(size != ref.size){
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kSize, String, size),
          size,
          ref.size,
          null,
        ),
      );
    }

    if(trailerClassDiff.isNotEmpty){
      aggregated.add(
        ObjectDifference(
          PropertyInfo(ktrailerClass, TrailerClass, trailerClass),
          trailerClass,
          ref.trailerClass,
          trailerClassDiff,
        ),
      );
    }

    if(statusDiff.isNotEmpty){
      aggregated.add(
        ObjectDifference(
          PropertyInfo(FoundationCommonPropertyKeys.kStatus, Status, status),
          status,
          ref.status,
          statusDiff,
        ),
      );
    }

    return aggregated;
  }
}
