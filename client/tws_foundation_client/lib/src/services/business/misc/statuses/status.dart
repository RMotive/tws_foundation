// ignore_for_file: missing_override_of_must_be_overridden

import 'package:csm_client_core/csm_client_core.dart';

/// {entity} class.
///
/// Implements from [NamedEntityBase], representing a {csm} business entity storing information
/// to represent a status for related entities.
final class Status extends NamedReferencedEntityB<Status> {

  /// Creates a new [Status] instance.
  Status();
  
  @override
  List<EntityErrors<Status>> evaluate(List<EntityErrors<Status>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) errors.add(EntityErrors<Status>(this, PropertyInfo(CorePropertiesConsts.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (reference.length != 8) errors.add(EntityErrors<Status>(this, PropertyInfo(CorePropertiesConsts.reference, String, reference), 'References characters lengh must be 8', 'strictLenght(8)'));
    if (name.trim().isEmpty || name.length > 100) errors.add(EntityErrors<Status>(this, PropertyInfo(CorePropertiesConsts.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null) {
      if (description!.length > 200) {
        errors.add(EntityErrors<Status>(this, PropertyInfo(CorePropertiesConsts.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      }
      if (description!.trim().isEmpty) errors.add(EntityErrors<Status>(this, PropertyInfo(CorePropertiesConsts.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    return errors;

  }
}
