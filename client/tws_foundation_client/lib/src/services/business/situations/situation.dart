import 'package:csm_client/csm_client.dart';

/// [Situation] default builder.
Situation situationBuilder() => Situation();

/// Defines a business entity that stores data for other business entities operating [Situation] status.
/// Defines if and entity is on the way, stored, parked, out of service, etc.
final class Situation extends NamedEntityB<Situation> {

  /// [reference] property key.
  static const String kReference = "reference";
  
  /// Unique identificator reference.
  String reference = "";

  /// [Status] navigation set.
  Status status = Status();

  /// Generates a new [Situation] instance from mandatory values.
  Situation();

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{},
    );
  }

  @override
  void decode(DataMap encode) {
    encode.entries;
    super.decode(encode);
  }

  @override
  List<EntityInvalidation<Situation>> evaluate() {
    List<EntityInvalidation<Situation>> results = <EntityInvalidation<Situation>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Situation>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<Situation>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null) {
      if (description!.length > 200) {
        results.add(EntityInvalidation<Situation>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      }
      if (description!.trim().isEmpty) results.add(EntityInvalidation<Situation>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    return results;
  }
}
