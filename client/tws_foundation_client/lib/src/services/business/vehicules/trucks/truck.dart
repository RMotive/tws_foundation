import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
// TODO: DEFINE
final class Truck extends EntityBase<Truck> {
  /// [Truck.motor] property key.
  static const String kMotor = 'motor';

  /// [Truck.vin] property key.
  static const String kVin = 'vin';

  /// [Truck.carrier] property key.
  static const String kCarrier = 'carrier';

  /// [Truck.sct] property key.
  static const String kSct = "SCT";

  /// [Truck.maintenance] property key.
  static const String kMaintenance = 'maintenance';

  /// [Truck.insurance] property key.
  static const String kInsurance = 'insurance';

  /// [Truck.model] property key.
  static const String kModel = 'model';

  /// [Truck.plates] property key.
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
  List<EntityErrors<Truck>> evaluate(List<EntityErrors<Truck>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
         EntityErrors<Truck>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }
    if (vin.trim().isEmpty || vin.length > 17) {
      errors.add(
        EntityErrors<Truck>(
          this,
          PropertyInfo(kVin, String, vin),
          'Lenght: ${vin.length}, cannot be empty or greater than 17 characters',
          '18 > length > 0',
        ),
      );
    }
    if (motor != null) {
      if (motor!.length < 15 && motor!.length > 16) {
        errors.add(
          EntityErrors<Truck>(
            this,
            PropertyInfo(kMotor, String, motor),
            'Lenght: ${motor!.length}, must be between 15 and 16 characters',
            '16 > length > 14',
          ),
        );
      }
    }

    errors.validateDependency(this, carrier);
    errors.validateDependency(this, model);
    if (sct != null) errors.validateDependency(this, sct!);
    if (maintenance != null) errors.validateDependency(this, maintenance!);
    if (insurance != null) errors.validateDependency(this, insurance!);
    if (plates.isNotEmpty) {
      for (Plate plate in plates) {
        errors.validateDependency(this, plate);
      }
    }
    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Truck ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> carrierDiff = carrier.compare(ref.carrier);
    List<ObjectDifference> modelDiff = model.compare(ref.model);

    if (vin != ref.vin) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kVin, String, vin),
          vin,
          ref.vin,
          null,
        ),
      );
    }
    if (motor != ref.motor) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kMotor, String, motor),
          motor,
          ref.motor,
          null,
        ),
      );
    }
    if (carrierDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kCarrier, Carrier, carrier),
          carrier,
          ref.carrier,
          carrierDiff,
        ),
      );
    }
    if (modelDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kModel, VehiculeModel, model),
          model,
          ref.model,
          modelDiff,
        ),
      );
    }

    if(ref.sct != null){
      List<ObjectDifference> sctDiff = sct?.compare(ref.sct!) ?? <ObjectDifference>[];

      if (sctDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kSct, SCT, sct),
            sct,
            ref.sct,
            sctDiff,
          ),
        );
      }
    }

    if(ref.maintenance != null){
      List<ObjectDifference> maintenanceDiff = maintenance?.compare(ref.maintenance!) ?? <ObjectDifference>[];

      if (maintenanceDiff.isNotEmpty) {
      aggregated.add(
          ObjectDifference(
            PropertyInfo(kMaintenance, Maintenance, maintenance),
            maintenance,
            ref.maintenance,
            maintenanceDiff,
          ),
        );
      }
    }
    
    if(ref.insurance != null){
      List<ObjectDifference> insuranceDiff =
          insurance?.compare(ref.insurance!) ?? <ObjectDifference>[];

      if (insuranceDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kInsurance, Insurance, insurance),
            insurance,
            ref.insurance,
            insuranceDiff,
          ),
        );
      }
    }
    
    for(Plate plate in plates){
      Plate? refPlate = ref.plates.firstWhere((Plate e) => e.id == plate.id, orElse: () => Plate());
      List<ObjectDifference> plateDiff = plate.compare(refPlate);

      if (plateDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kPlates, Plate, plate),
            plate,
            refPlate,
            plateDiff,
          ),
        );
      }
    }
    

    return aggregated;
  }
}
