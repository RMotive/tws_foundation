import 'package:csm_client_core/csm_client_core.dart';

/// [TrailerClass] default builder.
TrailerClass trailerClassBuilder() => TrailerClass();

/// Defines a business entity that stores the trailer type data, 
/// indicating the suitable load for the [Trailer] in this [TrailerClass].
final class TrailerClass extends NamedEntityBase<TrailerClass> {

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
  List<EntityErrors<TrailerClass>> evaluate(List<EntityErrors<TrailerClass>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<TrailerClass>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<TrailerClass>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        errors.add(
          EntityErrors<TrailerClass>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }
    return errors;
  }
  
  @override
  // ignore: unnecessary_overrides
  List<ObjectDifference> compare(TrailerClass ref, [List<ObjectDifference>? aggregated]) {
    return super.compare(ref, aggregated);
  }
}
