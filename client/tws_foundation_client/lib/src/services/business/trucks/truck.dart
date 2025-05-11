import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/carriers/carrier.dart';
import 'package:tws_foundation_client/src/services/business/vehicule_models/vehicule_model.dart';

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
  /// [plates] property key.
  static const String kPlates = 'plates';

  ///Vehicule identifier number.
  String vin = "";

  // Motor identifier.
  String? motor;

  /// Vehicule [Carrier] information.
  Carrier? carrier;

  /// [VehiculeModel] information.
  VehiculeModel? model;
  /// Generates a new [Truck] instance from mandatory values.
  Truck();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kVin: vin,
          kMotor: motor,

      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
  }

  @override
  List<EntityInvalidation<Truck>> evaluate() {
    List<EntityInvalidation<Truck>> results = <EntityInvalidation<Truck>>[];

    // if (name.isEmpty) results.add(EntityInvalidation<Solution>(this, PropertyInfo('Name', String, name), 'Solution name can\'t be empty', 'notEmpty'));
    // if (sign.length != 5) results.add(EntityInvalidation(kSign, 'Solution sign must be 5 length', 'strictLength(5)'));
    return results;
  }

}
