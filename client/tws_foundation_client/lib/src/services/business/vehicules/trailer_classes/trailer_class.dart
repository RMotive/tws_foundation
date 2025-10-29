import 'package:csm_client/csm_client.dart';

/// [TrailerClass] default builder.
TrailerClass trailerClassBuilder() => TrailerClass();

/// Defines a business entity that stores the trailer type data, 
/// indicating the suitable load for the [Trailer] in this [TrailerClass].
final class TrailerClass extends NamedEntityB<TrailerClass> {

  /// Generates a new [TrailerClass] instance from mandatory values.
  TrailerClass();

  factory TrailerClass.factory(String name, {String? description}) {
    TrailerClass trailerClass = TrailerClass();
    trailerClass.name = name;
    trailerClass.description = description;
    
    return trailerClass;
  }
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode();
  }
  
  @override
  // ignore: unnecessary_overrides
  void decode(DataMap encode) {
    super.decode(encode);
  }

  @override
  List<EntityInvalidation<TrailerClass>> evaluate() {
    List<EntityInvalidation<TrailerClass>> invalidations = <EntityInvalidation<TrailerClass>>[];
    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<TrailerClass>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      invalidations.add(
        EntityInvalidation<TrailerClass>(
          this,
          PropertyInfo(EntityKeys.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        invalidations.add(
          EntityInvalidation<TrailerClass>(
            this,
            PropertyInfo(EntityKeys.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }
    return invalidations;
  }

}
