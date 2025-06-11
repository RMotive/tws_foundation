import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

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

  ///Vehicule identifier number.
  String vin = "";

  // Motor identifier.
  String? motor;

  /// Vehicule [Carrier] information.
  Carrier carrier = Carrier();

  /// [VehiculeModel] information.
  VehiculeModel model = VehiculeModel();

  /// Generates a new [Truck] instance from mandatory values.
  Truck();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kVin: vin,
        kMotor: motor,
        kCarrier: carrier.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    vin = encode.get(kVin);
    motor = encode.get(kMotor, null);
    carrier.decode(encode.get(kCarrier));
    model.decode(encode.get(kModel));

    super.decode(encode);
  }

  @override
  List<EntityInvalidation<Truck>> evaluate() {
    List<EntityInvalidation<Truck>> results = <EntityInvalidation<Truck>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Truck>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (vin.trim().isEmpty || vin.length > 17) results.add(EntityInvalidation<Truck>(this, PropertyInfo(kVin, String, vin), 'VIN number must be not empty and max 17 length.', 'strictLength(1, 17)'));
    if (motor != null){
      if (motor!.length < 15 && motor!.length > 16) results.add(EntityInvalidation<Truck>(this, PropertyInfo(kMotor, String, motor), 'Motor number must be between 15 and 16 length', 'strictLength(15,16)'));
    }
    
    results.validateDependency(this, carrier);
    results.validateDependency(this, model);

    return results;
  }

}
