// ignore_for_file: missing_override_of_must_be_overridden

import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/extensions.dart';

/// [Situation] default builder.
Situation situationBuilder() => Situation();

/// Defines a business entity that stores data for other business entities operating [Situation] status.
/// Defines if and entity is on the way, stored, parked, out of service, etc.
// TODO Missing compare method implementation in entity base.
final class Situation extends NamedReferencedEntityB<Situation> {

  /// Generates a new [Situation] instance from mandatory values.
  Situation();

  /// Validate nulleable inputs to avoid [Situation] entities with empty values.
  Situation? sanitize({
    String? name,
    String? description,
    String? reference,
  }) {
    this.name = name.sanitizeOrFallback(this.name) ?? this.name;
    this.description = description.sanitizeOrFallback(this.description);
    this.reference = reference?.sanitizeOrFallback(this.reference) ?? this.reference;

    if (this.name.isEmpty && this.description == null && this.reference.isEmpty) {
      return null;
    }

    return this;
  }


  @override
  List<EntityErrors<Situation>> evaluate(List<EntityErrors<Situation>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Situation>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }
    if (reference.length != 8) {
      errors.add(
        EntityErrors<Situation>(
          this,
          PropertyInfo(CorePropertiesConsts.reference, String, reference),
          'lentgh: ${reference.length}, must be exactly 8 characters',
          'length == 8',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(  
        EntityErrors<Situation>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          "Length: ${name.length}, must be between 1 and 100 characters",
          "101 > length > 0",
        ),
      );
    }
    if (description != null && (description!.trim().isEmpty || description!.length > 200)) {
      errors.add(
        EntityErrors<Situation>(
          this,
          PropertyInfo(CorePropertiesConsts.description, String, description),
          "Description must be 200 max length",
          "strictLength(200)",
        ),
      );
    }
    return errors;
  }

  @override
  List<ObjectDifference> compare(Situation ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    if(name != ref.name) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.name, String, name),
          name,
          ref.name,
          null,
        ),
      );
    }

     if(description != ref.description) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.description, String, description),
          description,
          ref.description,
          null,
        ),
      );
    }

     if(reference != ref.reference) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(CorePropertiesConsts.reference, String, reference),
          reference,
          ref.reference,
          null,
        ),
      );
    }

    return aggregated;
  }
  
}
