import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/core/extensions.dart';
import 'package:tws_foundation_client/src/services/business/vehicules/trailer_classes/trailer_class.dart';

/// [TrailerType] default builder.
TrailerType trailertypeBuilder() => TrailerType();


/// Defines a business entity that stores relevant data for a trailer operation, like [size] or [TrailerClass]. 
final class TrailerType extends EntityB<TrailerType> {
  /// [TrailerType.size] property key.
  static const String kSize = "size";

  /// [TrailerType.trailerClass] property key.
  static const String ktrailerClass = "trailerClass";

  /// Trailer dimensions.
  /// 
  /// rules >
  /// 1. 17 > Length > 0
  String size = "";

  /// Foregin relation [TrailerClass] object.
  TrailerClass trailerClass = TrailerClass();

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
      },
    );
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    size = encode.get(kSize);
    trailerClass = encode.getEntity(() => TrailerClass(), ktrailerClass) ?? TrailerClass();
  }

  @override
  List<EntityInvalidation<TrailerType>> evaluate() {
    List<EntityInvalidation<TrailerType>> invalidations = <EntityInvalidation<TrailerType>>[];
    if (id < BigInt.zero) {
      invalidations.add(
         EntityInvalidation<TrailerType>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          'id < 0',
        ),
      );
    }

    if (size.trim().isEmpty || size.length > 16) {
      invalidations.add(
        EntityInvalidation<TrailerType>(
          this,
          PropertyInfo(kSize, String, size),
          'Length: $size, can\'t be empty or longer than 16.',
          '17 > Length > 0',
        ),
      );
    }

    invalidations.validateDependency(this, trailerClass);

    return invalidations;
  }
}
