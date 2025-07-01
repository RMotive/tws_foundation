import 'package:csm_client/csm_client.dart';

/// [Manufacturer] default builder.
Manufacturer manufacturerBuilder() => Manufacturer();

/// Defines a business entity that stores the [Manufacturer] data for [Trucks] entities.
final class Manufacturer extends NamedEntityB<Manufacturer> {
  /// Generates a new [Manufacturer] instance from mandatory values.
  Manufacturer();

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{},
    );
  }

  @override
  List<EntityInvalidation<Manufacturer>> evaluate() {
    List<EntityInvalidation<Manufacturer>> results = <EntityInvalidation<Manufacturer>>[];

    if (id < BigInt.zero) results.add(EntityInvalidation<Manufacturer>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<Manufacturer>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null) {
      if (description!.length > 200) {
        results.add(EntityInvalidation<Manufacturer>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      }
      if (description!.trim().isEmpty) {
        results.add(EntityInvalidation<Manufacturer>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
      }
    }

    return results;
  }

  @override
  void decode(DataMap encode) {
    encode.entries;

    super.decode(encode);
  }
}
