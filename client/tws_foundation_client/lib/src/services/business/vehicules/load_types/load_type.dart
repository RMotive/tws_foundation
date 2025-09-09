// ignore_for_file: missing_override_of_must_be_overridden

import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [LoadType] default builder.
LoadType loadtypeBuilder() => LoadType();

/// Defines a business entity that stores the data for load types that can be asigned to [Trailer] entities.
final class LoadType extends NamedReferencedEntityB<LoadType> {
  
  /// Generates a new [LoadType] instance from mandatory values.
  LoadType();
  
  @override
  List<EntityInvalidation<LoadType>> evaluate() {
    List<EntityInvalidation<LoadType>> results = <EntityInvalidation<LoadType>>[];
    if (id < BigInt.zero) {
      results.add(
        EntityInvalidation<LoadType>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      results.add(
        EntityInvalidation<LoadType>(
          this,
          PropertyInfo(EntityKeys.name, String, name),
          "Lenght: ${name.length}, must be between 1 and 100 characters.",
          "101 > length > 0",
        ),
      );
    }
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        results.add(
          EntityInvalidation<LoadType>(
            this,
            PropertyInfo(EntityKeys.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }
    if (reference.length != 8) {
      results.add(
        EntityInvalidation<LoadType>(
          this,
          PropertyInfo(EntityKeys.kReference, String, reference),
          "Reference value must contain 8 characters",
          "strictLength(8)",
        ),
      );
    }
    return results;
  }

}
