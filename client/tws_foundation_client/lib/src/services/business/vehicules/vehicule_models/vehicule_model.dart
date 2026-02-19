import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';



/// [VehiculeModel] default builder.
VehiculeModel vehiculemodelBuilder() => VehiculeModel();

final class VehiculeModel extends NamedEntityBase<VehiculeModel> {

  /// [year] property key.
  static const String kYear = 'year';

  /// [manufacturer] property key.
  static const String kManufacturer = 'manufacturer';

  /// Model year.
  DateTime year = DateTime(0);
  
  /// Manufacturer property.
  Manufacturer manufacturer = Manufacturer();

  /// Model Status.
  Status status = Status();

  /// Generates a new [VehiculeModel] instance from mandatory values.
  VehiculeModel();
  
  /// Validate nulleable inputs to avoid [VehiculeModel] entities with empty values.
  VehiculeModel? sanitize({
    String? name,
    String? description,
    DateTime? year,
    Manufacturer? manufacturer,
  }) {
    this.year = year ?? this.year;
    this.manufacturer = manufacturer ?? this.manufacturer;
    this.name = name.sanitizeOrFallback(this.name) ?? '';
    this.description = description.sanitizeOrFallback(this.description);
    if (this.name.isEmpty && this.description == null && this.year == DateTime(0) && this.manufacturer.id < BigInt.zero) {
      return null;
    }

    return this;
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
        kYear: year.dateOnlyIso,
        kManufacturer: manufacturer.encode(),
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    year = encode.get(kYear);
    manufacturer = encode.getEntity(() => Manufacturer(), kManufacturer) ?? manufacturer;
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? Status();
  }

  @override
  List<EntityErrors<VehiculeModel>> evaluate(List<EntityErrors<VehiculeModel>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<VehiculeModel>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<VehiculeModel>(
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
          EntityErrors<VehiculeModel>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }

    errors.validateDependency(this, manufacturer);
    errors.validateDependency(this, status);
    return errors;
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }
}
