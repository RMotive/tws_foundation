import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Manufacturer] default builder.
Manufacturer manufacturerBuilder() => Manufacturer();

/// Defines a business entity that stores the [Manufacturer] data for [Trucks] entities.
final class Manufacturer extends NamedEntityBase<Manufacturer> {
  /// Generates a new [Manufacturer] instance from mandatory values.
  Manufacturer();

  Manufacturer? sanitize({
    String? name,
    String? description,
  }) {
    this.name = name.sanitizeOrFallback(this.name) ?? '';
    this.description = description.sanitizeOrFallback(this.description);

    if (this.name.isEmpty && this.description == null) {
      return null;
    }

    return this;
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{},
    );
  }

  @override
  List<EntityErrors<Manufacturer>> evaluate(List<EntityErrors<Manufacturer>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Manufacturer>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id cannot be less than 0',
          'id < 0',
        ),
      );
    }

    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Manufacturer>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          "Length: ${name.length}, must be between 1 and 100 characters",
          "101 > length > 0",
        ),
      );
    }
    
    if (description != null && (description!.isEmpty  || description!.length > 200)) {
      errors.add(
        EntityErrors<Manufacturer>(
          this,
          PropertyInfo(CorePropertiesConsts.description, String, description),
          "Length: ${description!.length}, must be empty or greater than 200 characters",
          " length < 200",
        ),
      );
    }

    return errors;
  }

  @override
  void decode(DataMap encode) {
    encode.entries;

    super.decode(encode);
  }
  
  @override
  // ignore: unnecessary_overrides
  List<ObjectDifference> compare(Manufacturer ref, [List<ObjectDifference>? aggregated]) {
    return super.compare(ref, aggregated);
  }
}
