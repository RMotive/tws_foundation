import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Truck implements CSMSetInterface {
  static const String kVin = 'vin';
  static const String kManufacturer = 'manufacturer';
  static const String kMotor = 'motor';
  static const String kSCT = 'sct';
  static const String kMaintenance = 'maintenace';
  static const String kSituation = 'situation';
  static const String kInsurance = 'insurance';
  static const String kManufacturerNavigation = 'ManufacturerNavigation';
  static const String kSctNavigation = 'SctNavigation';
  static const String kMaintenanceNavigation = 'MaintenanceNavigation';
  static const String kSituationNavigation = 'SituationNavigation';
  static const String kInsuranceNavigation = 'InsuranceNavigation';
  static const String kPlates = 'plates';
  static final DateTime timePlaceholder = DateTime.now();

  @override
  int id = 0;
  String vin = '';
  int manufacturer = 0;
  String motor = '';
  int? sct;
  int? maintenance;
  int? situation;
  int? insurance;
  Manufacturer? manufacturerNavigation;
  SCT? sctNavigation;
  Maintenance? maintenanceNavigation;
  Situation? situationNavigation;
  Insurance? insuranceNavigation;
  // List default initialization data for clone method.
  List<Plate> plates = <Plate>[Plate(0, "", "", "", timePlaceholder, 0, null), Plate(0, "", "", "", timePlaceholder, 0, null)];

  Truck.def();

  Truck(this.id, this.vin, this.manufacturer, this.motor, this.sct, this.maintenance, this.situation, this.insurance, this.manufacturerNavigation, this.sctNavigation, this.maintenanceNavigation,
      this.situationNavigation, this.insuranceNavigation, this.plates);
  factory Truck.des(JObject json) {
    List<Plate> plates = <Plate>[];
    int id = json.get('id');
    String vin = json.get('vin');
    int manufacturer = json.get('manufacturer');
    String motor = json.get('motor');
    int? sct = json.getDefault('sct', null);
    int? maintenance = json.getDefault('maintenance', null);
    int? situation = json.getDefault('situation', null);
    int? insurance = json.getDefault('insurance', null);
    Manufacturer? manufacturerNavigation;
    SCT? sctNavigation;
    Maintenance? maintenanceNavigation;
    Situation? situationNavigation;
    Insurance? insuranceNavigation;

    List<JObject> rawPlateArray = json.getList('Plates');
    plates = rawPlateArray.map<Plate>((JObject e) => deserealize(e, decode: PlateDecoder())).toList();

    //Optional parameters validation.
    if (json['ManufacturerNavigation'] != null) {
      JObject rawNavigation = json.getDefault('ManufacturerNavigation', <String, dynamic>{});
      manufacturerNavigation = deserealize<Manufacturer>(rawNavigation, decode: ManufacturerDecoder());
    }
    if (json['SctNavigation'] != null) {
      JObject rawNavigation = json.getDefault('SctNavigation', <String, dynamic>{});
      sctNavigation = deserealize<SCT>(rawNavigation, decode: SCTDecoder());
    }
    if (json['MaintenanceNavigation'] != null) {
      JObject rawNavigation = json.getDefault('MaintenanceNavigation', <String, dynamic>{});
      maintenanceNavigation = deserealize<Maintenance>(rawNavigation, decode: MaintenanceDecoder());
    }
    if (json['SituationNavigation'] != null) {
      JObject rawNavigation = json.getDefault('SituationNavigation', <String, dynamic>{});
      situationNavigation = deserealize<Situation>(rawNavigation, decode: SituationDecoder());
    }
    if (json['InsuranceNavigation'] != null) {
      JObject rawNavigation = json.getDefault('InsuranceNavigation', <String, dynamic>{});
      insuranceNavigation = deserealize<Insurance>(rawNavigation, decode: InsuranceDecoder());
    }
    return Truck(id, vin, manufacturer, motor, sct, maintenance, situation, insurance, manufacturerNavigation, sctNavigation, maintenanceNavigation, situationNavigation, insuranceNavigation, plates);
  }
  Truck clone(
      {int? id,
      String? vin,
      int? manufacturer,
      String? motor,
      int? sct,
      int? maintenance,
      int? situation,
      int? insurance,
      Manufacturer? manufacturerNavigation,
      SCT? sctNavigation,
      Maintenance? maintenanceNavigation,
      Situation? situationNavigation,
      Insurance? insuranceNavigation,
      List<Plate>? plates}) {
    return Truck(
        id ?? this.id,
        vin ?? this.vin,
        manufacturer ?? this.manufacturer,
        motor ?? this.motor,
        sct ?? this.sct,
        maintenance ?? this.maintenance,
        situation ?? this.situation,
        insurance ?? this.insurance,
        manufacturerNavigation ?? this.manufacturerNavigation,
        sctNavigation ?? this.sctNavigation,
        maintenanceNavigation ?? this.maintenanceNavigation,
        situationNavigation ?? this.situationNavigation,
        insuranceNavigation ?? this.insuranceNavigation,
        plates ?? this.plates);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kVin: vin,
      kManufacturer: manufacturer,
      kMotor: motor,
      kSCT: sct,
      kMaintenance: maintenance,
      kSituation: situation,
      kInsurance: insurance,
      kManufacturerNavigation: manufacturerNavigation?.encode(),
      kSctNavigation: sctNavigation?.encode(),
      kMaintenanceNavigation: maintenanceNavigation?.encode(),
      kSituationNavigation: situationNavigation?.encode(),
      kInsuranceNavigation: insuranceNavigation?.encode(),
      kPlates: plates.map((Plate i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];

    if (vin.length != 17) results.add(CSMSetValidationResult(kVin, 'VIN number must be 17 length', 'strictLength(17)'));
    if (motor.length < 15 && motor.length > 16) results.add(CSMSetValidationResult(kMotor, 'Motor number must be between 15 and 16 length', 'strictLength(15,16)'));
    if (manufacturer < 0) results.add(CSMSetValidationResult(kManufacturer, 'Manufactuer pointer must be equal or greater than 0', 'pointerHandler()'));
    if (manufacturer > 0 && manufacturerNavigation != null) {
      results.add(CSMSetValidationResult("[$kManufacturer, $kManufacturerNavigation]", 'Must be only one Manufacturer insertion, pointer or navigation property', 'insertionConflict()'));
    }
    if (manufacturer == 0 && manufacturerNavigation == null) {
      results.add(CSMSetValidationResult("[$kManufacturer, $kManufacturerNavigation]", 'Required Manufacturer. Must be one Manufacturer insertion property', 'requiredInsertion()'));
    }
    if (plates.length != 2) results.add(CSMSetValidationResult(kPlates, 'Plates list must contain 2 objects', 'listLength(2)'));

    if (sct != null && sctNavigation != null) results.add(CSMSetValidationResult("[$kSCT, $kSctNavigation]", 'Must be only one SCT insertion, pointer or navigation property', 'insertionConflict()'));
    if (maintenance != null && maintenanceNavigation != null) {
      results.add(CSMSetValidationResult("[$kMaintenance, $kMaintenanceNavigation]", 'Must be only one Maintenance insertion, pointer or navigation property', 'insertionConflict()'));
    }
    if (situation != null && situationNavigation != null) {
      results.add(CSMSetValidationResult("[$kSituation, $kSituationNavigation]", 'Must be only one Situation insertion, pointer or navigation property', 'insertionConflict()'));
    }
    if (insurance != null && insuranceNavigation != null) {
      results.add(CSMSetValidationResult("[$kInsurance, $kInsuranceNavigation]", 'Must be only one Insurance insertion, pointer or navigation property', 'insertionConflict()'));
    }

    if (sct != null && sct! < 0) results.add(CSMSetValidationResult(kSCT, 'SCT pointer must be equal or greater than 0', 'pointerHandler()'));
    if (maintenance != null && maintenance! < 0) results.add(CSMSetValidationResult(kMaintenance, 'Maintenance pointer must be equal or greater than 0', 'pointerHandler()'));
    if (situation != null && situation! < 0) results.add(CSMSetValidationResult(kSituation, 'Situation pointer must be equal or greater than 0', 'pointerHandler()'));
    if (insurance != null && insurance! < 0) results.add(CSMSetValidationResult(kInsurance, 'Insurance pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
}

final class TruckDecoder implements CSMDecodeInterface<Truck> {
  const TruckDecoder();

  @override
  Truck decode(JObject json) {
    return Truck.des(json);
  }
}
