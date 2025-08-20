import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
// TODO: DEFINE
final class Truck extends EntityB<Truck> {
  /// [motor] property key.
  static const String kMotor = 'motor';

  /// [vin] property key.
  static const String kVin = 'vin';

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
  static const String kPlates = 'Plates';

  //! --> Properties

  /// Motor identifier.
  /// rules >
  /// 1 : 16 > length > 14
  String? motor;

  ///Vehicule identifier number.
  /// rules >
  /// 1 : 18 > length > 0
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

  /// [Insurance] information.
  Insurance? insurance;

  /// [Plate]s information.
  List<Plate> plates = <Plate>[];

  //! <-- Relations

  /// Generates a new [Truck] instance from mandatory values.
  Truck();

  @override
  DataMap encode([DataMap? entityObject]) {
    TruckCommon common = TruckCommon();
    Status status = Status();
    status.reference = 'referdef';
    common.status = status;
    common.economic = "economicholder";

    return super.encode(
      <String, Object?>{
        kVin: vin,
        kMotor: motor,
        kCarrier: carrier.encode(),
        kSct: sct?.encode(),
        kModel: model.encode(),
        kMaintenance: maintenance?.encode(),
        kInsurance: insurance?.encode(),
        kPlates: plates
            .map(
              (Plate e) => e.encode(),
            )
            .toList(),
        'common': common.encode(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    vin = encode.get(kVin);
    motor = encode.get(kMotor, null);

    carrier = encode.getEntity(() => Carrier(), kCarrier) ?? carrier;
    model = encode.getEntity(() => VehiculeModel(), kModel) ?? model;
    insurance = encode.getEntity(() => Insurance(), kInsurance);
    sct = encode.getEntity(() => SCT(), kSct);
    maintenance = encode.getEntity(() => Maintenance(), kMaintenance);
    List<DataMap> platesMaps = encode.getList(kPlates);
    if (platesMaps.isNotEmpty) {
      plates = platesMaps.map<Plate>(
        (DataMap e) {
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
    if (id < BigInt.zero) {
      results.add(
         EntityInvalidation<Truck>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }
    if (vin.trim().isEmpty || vin.length > 17) {
      results.add(
        EntityInvalidation<Truck>(
          this,
          PropertyInfo(kVin, String, vin),
          'Lenght: ${vin.length}, cannot be empty or greater than 17 characters',
          '18 > length > 0',
        ),
      );
    }
    if (motor != null) {
      if (motor!.length < 15 && motor!.length > 16) {
        results.add(
          EntityInvalidation<Truck>(
            this,
            PropertyInfo(kMotor, String, motor),
            'Lenght: ${motor!.length}, must be between 15 and 16 characters',
            '16 > length > 14',
          ),
        );
      }
    }

    results.validateDependency(this, carrier);
    results.validateDependency(this, model);
    if (sct != null) results.validateDependency(this, sct!);
    if (maintenance != null) results.validateDependency(this, maintenance!);
    if (insurance != null) results.validateDependency(this, insurance!);
    if (plates.isNotEmpty) {
      for (Plate plate in plates) {
        results.validateDependency(this, plate);
      }
    }
    return results;
  }
}
