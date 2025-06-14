import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// TODO: DEFINE
final class Truck extends EntityB<Truck> {
  /// [motor] property key.
  static const String kMotor = 'motor';

  /// [vin] property key.
  static const String kVin = 'model';

  /// [carrier] property key.
  static const String kCarrier = 'carrier';

  /// [sct] property key.
  static const String kSct = "sct";

  /// [maintenance] property key.
  static const String kMaintenance = 'maintenance';

  /// [insurance] property key.
  static const String kInsurance = 'insurance';

  /// [model] property key.
  static const String kModel = 'model';

  /// [plates] property key.
  static const String kPlates = 'plates';

  //! --> Properties

  /// Motor identifier.
  String? motor;

  ///Vehicule identifier number.
  String vin = "";

  //! <-- Properties

  //! --> Relations

  /// Vehicule [Carrier] information.
  Carrier carrier = Carrier();

  /// [VehiculeModel] information.
  VehiculeModel model = VehiculeModel();

  /// [SCT] information.
  SCT? sct;

  /// [Maintenance] information.
  Maintenance? maintenance;

  /// [Plate]s information.
  List<Plate> plates = <Plate>[];

  //! <-- Relations

  /// Generates a new [Truck] instance from mandatory values.
  Truck();

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kVin: vin,
        kMotor: motor,
        kCarrier: carrier.encode(),
        kSct: sct?.encode(),
        kModel: model.encode(),
        kMaintenance: maintenance?.encode(),
        kPlates: plates
            .map(
              (Plate e) => e.encode(),
            )
            .toList(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    vin = encode.get(kVin);
    motor = encode.get(kMotor, null);

    carrier = encode.getEntity(() => Carrier(), kCarrier) ?? carrier;
    model = encode.getEntity(() => VehiculeModel(), kModel) ?? model;

    sct = encode.getEntity(() => SCT(), kSct);
    maintenance = encode.getEntity(() => Maintenance(), kMaintenance);

    List<DataMap> platesMaps = encode.get(kPlates);
    if (platesMaps.isNotEmpty) {
      plates = platesMaps.map<Plate>(
        (Map<String, Object?> e) {
          Plate plate = Plate();
          plate.decode(e);
          return plate;
        },
      ).toList();
    }

    super.decode(encode);
  }

  @override
  List<EntityInvalidation<Truck>> evaluate() {
    List<EntityInvalidation<Truck>> results = <EntityInvalidation<Truck>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Truck>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (vin.trim().isEmpty || vin.length > 17) results.add(EntityInvalidation<Truck>(this, PropertyInfo(kVin, String, vin), 'VIN number must be not empty and max 17 length.', 'strictLength(1, 17)'));
    if (motor != null) {
      if (motor!.length < 15 && motor!.length > 16)
        results.add(EntityInvalidation<Truck>(this, PropertyInfo(kMotor, String, motor), 'Motor number must be between 15 and 16 length', 'strictLength(15,16)'));
    }

    results.validateDependency(this, carrier);
    results.validateDependency(this, model);

    return results;
  }
}
