import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Truck implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kManufacturer = 'manufacturer';
  static const String kCommon = 'common';
  static const String kCarrier = 'carrier';
  static const String kMotor = 'motor';
  static const String kVin = "vin";
  static const String kMaintenance = 'maintenace';
  static const String kInsurance = 'insurance';
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kManufacturerNavigation = 'ManufacturerNavigation';
  static const String kTruckCommonNavigation = 'TruckCommonNavigation';
  static const String kMaintenanceNavigation = 'MaintenanceNavigation';
  static const String kInsuranceNavigation = 'InsuranceNavigation';
  static const String kCarrierNavigation = 'CarrierNavigation';
  static const String kPlates = 'plates';

  @override
  int id = 0;
  int status = 1;
  int manufacturer = 0;
  int common = 0;
  int carrier = 0;
  String vin = "";
  String motor = '';
  int? maintenance;
  int? insurance;
  Status? statusNavigation;
  TruckCommon? truckCommonNavigation;
  Manufacturer? manufacturerNavigation;
  Maintenance? maintenanceNavigation;
  Insurance? insuranceNavigation;
  Carrier? carrierNavigation;

  // List default initialization data for clone method.
  List<Plate> plates = <Plate>[Plate.def(), Plate.def()];

  Truck(this.id, this.status, this.manufacturer, this.common, this.carrier, this.motor, this.vin, this.maintenance, this.insurance, this.statusNavigation, this.manufacturerNavigation,
      this.truckCommonNavigation, this.maintenanceNavigation, this.insuranceNavigation, this.carrierNavigation, this.plates);

  Truck.def();

  factory Truck.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    int manufacturer = json.get(kManufacturer);
    int common = json.get(kCommon);
    int carrier = json.get(kCarrier);
    String vin = json.get(kVin);
    String motor = json.get(kMotor);
    int? maintenance = json.getDefault(kMaintenance, null);
    int? insurance = json.getDefault(kInsurance, null);
    Status? statusNavigation;
    TruckCommon? truckCommonNavigation;
    Manufacturer? manufacturerNavigation;
    Maintenance? maintenanceNavigation;
    Insurance? insuranceNavigation;
    Carrier? carrierNavigation;
    List<Plate> plates = <Plate>[];
    List<JObject> rawPlateArray = json.getList(kPlates);
    plates = rawPlateArray.map<Plate>(Plate.des).toList();

    //Optional parameters validation.
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    if (json[kTruckCommonNavigation] != null) {
      JObject rawNavigation = json.getDefault(kTruckCommonNavigation, <String, dynamic>{});
      truckCommonNavigation = TruckCommon.des(rawNavigation);
    }

    if (json[kManufacturerNavigation] != null) {
      JObject rawNavigation = json.getDefault(kManufacturerNavigation, <String, dynamic>{});
      manufacturerNavigation = Manufacturer.des(rawNavigation);
    }

    if (json[kMaintenanceNavigation] != null) {
      JObject rawNavigation = json.getDefault(kMaintenanceNavigation, <String, dynamic>{});
      maintenanceNavigation = Maintenance.des(rawNavigation);
    }

    if (json[kInsuranceNavigation] != null) {
      JObject rawNavigation = json.getDefault(kInsuranceNavigation, <String, dynamic>{});
      insuranceNavigation = Insurance.des(rawNavigation);
    }

    if (json[kCarrierNavigation] != null) {
      JObject rawNavigation = json.getDefault(kCarrierNavigation, <String, dynamic>{});
      carrierNavigation = Carrier.des(rawNavigation);
    }
    return Truck(id, status, manufacturer, common, carrier, motor, vin, maintenance, insurance, statusNavigation, manufacturerNavigation, truckCommonNavigation, maintenanceNavigation,
        insuranceNavigation, carrierNavigation, plates);
  }
  Truck clone({
    int? id,
    int? status,
    int? manufacturer,
    String? motor,
    String? vin,
    int? maintenance,
    int? common,
    int? carrier,
    int? insurance,
    Status? statusNavigation,
    Manufacturer? manufacturerNavigation,
    TruckCommon? truckCommonNavigation,
    Maintenance? maintenanceNavigation,
    Insurance? insuranceNavigation,
    Carrier? carrierNavigation,
    List<Plate>? plates,
  }) {
    // If the field is set via catalogs, then the pointers must be setted null when index is 0
    Manufacturer? manufacturerNav = manufacturerNavigation ?? this.manufacturerNavigation;
    if (manufacturer == 0) manufacturerNav = null;

    return Truck(
      id ?? this.id,
      status ?? this.status,
      manufacturer ?? this.manufacturer,
      common ?? this.common,
      carrier ?? this.carrier,
      motor ?? this.motor,
      vin ?? this.vin,
      maintenance ?? this.maintenance,
      insurance ?? this.insurance,
      statusNavigation ?? this.statusNavigation,
      manufacturerNav,
      truckCommonNavigation ?? this.truckCommonNavigation,
      maintenanceNavigation ?? this.maintenanceNavigation,
      insuranceNavigation ?? this.insuranceNavigation,
      carrierNavigation ?? this.carrierNavigation,
      plates ?? this.plates,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kManufacturer: manufacturer,
      kCommon: common,
      kCarrier: carrier,
      kMotor: motor,
      kVin: vin,
      kMaintenance: maintenance,
      kInsurance: insurance,
      kstatusNavigation: statusNavigation?.encode(),
      kManufacturerNavigation: manufacturerNavigation?.encode(),
      kTruckCommonNavigation: truckCommonNavigation?.encode(),
      kMaintenanceNavigation: maintenanceNavigation?.encode(),
      kInsuranceNavigation: insuranceNavigation?.encode(),
      kCarrierNavigation: carrierNavigation?.encode(),
      kPlates: plates.map((Plate i) => i.encode()).toList()
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (vin.length != 17) results.add(CSMSetValidationResult(kVin, 'VIN number must be 17 length', 'strictLength(17)'));
    if (motor.length < 15 && motor.length > 16) results.add(CSMSetValidationResult(kMotor, 'Motor number must be between 15 and 16 length', 'strictLength(15,16)'));
    if (manufacturer < 0) results.add(CSMSetValidationResult(kManufacturer, 'Manufactuer pointer must be equal or greater than 0', 'pointerHandler()'));
    if (carrier < 0) results.add(CSMSetValidationResult(kCarrier, 'Carrier pointer must be equal or greater than 0', 'pointerHandler()'));
    if (manufacturer > 0 && manufacturerNavigation != null) {
      if (manufacturer != manufacturerNavigation!.id) {
        results.add(CSMSetValidationResult(
            "[$kManufacturer, $kManufacturerNavigation]",
            'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.',
            'insertionConflict()'));
      }
    }

    if (manufacturer == 0 && manufacturerNavigation == null) {
      results.add(CSMSetValidationResult("[$kManufacturer, $kManufacturerNavigation]", 'Required Manufacturer. Must be one Manufacturer insertion property', 'requiredInsertion()'));
    }

    if ((manufacturer != 0 && manufacturerNavigation != null) && (manufacturerNavigation!.id != manufacturer)) {
      results.add(CSMSetValidationResult(
          "[$kManufacturer, $kManufacturerNavigation]",
          'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.',
          'insertionConflict()'));
    }

    if (maintenance != null && maintenanceNavigation != null) {
      if (maintenance != 0 && (maintenanceNavigation!.id != maintenance)) {
        results.add(CSMSetValidationResult(
            "[$kMaintenance, $kMaintenanceNavigation]",
            'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.',
            'insertionConflict()'));
      }
    }
    if (insurance != null && insuranceNavigation != null) {
      if (insurance != 0 && (insuranceNavigation!.id != insurance)) {
        results.add(CSMSetValidationResult(
            "[$kInsurance, $kInsurance]",
            'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.',
            'insertionConflict()'));
      }
    }

    if (maintenance != null && maintenance! < 0) results.add(CSMSetValidationResult(kMaintenance, 'Maintenance pointer must be equal or greater than 0', 'pointerHandler()'));
    if (insurance != null && insurance! < 0) results.add(CSMSetValidationResult(kInsurance, 'Insurance pointer must be equal or greater than 0', 'pointerHandler()'));

    //Models validations
    if (manufacturerNavigation != null) results = <CSMSetValidationResult>[...results, ...manufacturerNavigation!.evaluate()];
    if (maintenanceNavigation != null) results = <CSMSetValidationResult>[...results, ...maintenanceNavigation!.evaluate()];
    if (insuranceNavigation != null) results = <CSMSetValidationResult>[...results, ...insuranceNavigation!.evaluate()];

    if (plates.length != 2) results.add(CSMSetValidationResult(kPlates, 'Plates list must contain 2 objects', 'listLength(2)'));
    for (Plate plate in plates) {
      results = <CSMSetValidationResult>[...results, ...plate.evaluate()];
    }
    return results;
  }
}
