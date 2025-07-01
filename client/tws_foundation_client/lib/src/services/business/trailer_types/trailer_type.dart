import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/services/business/trailer_classes/trailer_class.dart';

/// [TrailerType] default builder.
TrailerType trailertypeBuilder() => TrailerType();


/// Defines a business entity that stores relevant data for a trailer operation, like [size] or [TrailerClass]. 
final class TrailerType extends EntityB<TrailerType> {
  /// [size] property key.
  static const String kSize = "size";

  /// [trailerClass] property key.
  static const String ktrailerClass = "trailerClass";

  /// Trailer dimensions.
  String size = "";

  /// Foregin relation [TrailerClass] object.
  TrailerClass trailerClass = TrailerClass();

  /// Generates a new [TrailerType] instance from mandatory values.
  TrailerType();

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
    trailerClass = TrailerClass();
    size = encode.get(kSize);
    trailerClass.decode(encode.get(ktrailerClass, DataMap()));
  }

  @override
  List<EntityInvalidation<TrailerType>> evaluate() {
    List<EntityInvalidation<TrailerType>> results = <EntityInvalidation<TrailerType>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<TrailerType>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));

    if (size.trim().isEmpty) results.add(EntityInvalidation<TrailerType>(this, PropertyInfo(kSize, String, size), 'Size can\'t be empty', 'notEmpty'));
    if (size.length > 16) results.add(EntityInvalidation<TrailerType>(this, PropertyInfo(kSize, String, size), 'Size must be 16 max length', 'StrictLength(16)'));

    results.validateDependency(this, trailerClass);

    return results;
  }
}
