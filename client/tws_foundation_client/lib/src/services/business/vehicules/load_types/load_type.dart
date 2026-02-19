// ignore_for_file: missing_override_of_must_be_overridden

import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [LoadType] default builder.
LoadType loadtypeBuilder() => LoadType();

/// Defines a business entity that stores the data for load types that can be asigned to [Trailer] entities.
final class LoadType extends NamedReferencedEntityB<LoadType> {
  
  /// Generates a new [LoadType] instance from mandatory values.
  LoadType();
  
  @override
  List<EntityErrors<LoadType>> evaluate(List<EntityErrors<LoadType>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<LoadType>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<LoadType>(
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
          EntityErrors<LoadType>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }
    if (reference.length != 8) {
      errors.add(
        EntityErrors<LoadType>(
          this,
          PropertyInfo(CorePropertiesConsts.reference, String, reference),
          "Reference value must contain 8 characters",
          "strictLength(8)",
        ),
      );
    }
    return errors;
  }

}
