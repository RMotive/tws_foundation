import 'package:csm_foundation_services/csm_foundation_services.dart';
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
  List<Plate> plates = <Plate>[
    Plate.def(),
    Plate.def()
  ];

  Truck.def();

  Truck(this.id, this.status, this.manufacturer, this.common, this.carrier, this.motor, this.vin, this.maintenance, this.insurance, this.statusNavigation, this.manufacturerNavigation, this.truckCommonNavigation, this.maintenanceNavigation,
    this.insuranceNavigation, this.carrierNavigation, this.plates);
  factory Truck.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int manufacturer = json.get('manufacturer');
    int common = json.get('common');
    int carrier = json.get('carrier');
    String vin = json.get('vin');
    String motor = json.get('motor');
    int? maintenance = json.getDefault('maintenance', null);
    int? insurance = json.getDefault('insurance', null);
    Status? statusNavigation;
    TruckCommon? truckCommonNavigation;
    Manufacturer? manufacturerNavigation;
    Maintenance? maintenanceNavigation;
    Insurance? insuranceNavigation;
    Carrier? carrierNavigation;
    List<Plate> plates = <Plate>[];
    List<JObject> rawPlateArray = json.getList('Plates');
    plates = rawPlateArray.map<Plate>((JObject e) => deserealize(e, decode: PlateDecoder())).toList();

    //Optional parameters validation.
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    if (json['TruckCommonNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TruckCommonNavigation', <String, dynamic>{});
      truckCommonNavigation = deserealize<TruckCommon>(rawNavigation, decode: TruckCommonDecoder());
    }

    if (json['ManufacturerNavigation'] != null) {
      JObject rawNavigation = json.getDefault('ManufacturerNavigation', <String, dynamic>{});
      manufacturerNavigation = deserealize<Manufacturer>(rawNavigation, decode: ManufacturerDecoder());
    }
    
    if (json['MaintenanceNavigation'] != null) {
      JObject rawNavigation = json.getDefault('MaintenanceNavigation', <String, dynamic>{});
      maintenanceNavigation = deserealize<Maintenance>(rawNavigation, decode: MaintenanceDecoder());
    }

    if (json['InsuranceNavigation'] != null) {
      JObject rawNavigation = json.getDefault('InsuranceNavigation', <String, dynamic>{});
      insuranceNavigation = deserealize<Insurance>(rawNavigation, decode: InsuranceDecoder());
    }

    if (json['CarrierNavigation'] != null) {
      JObject rawNavigation = json.getDefault('CarrierNavigation', <String, dynamic>{});
      carrierNavigation = deserealize<Carrier>(rawNavigation, decode: CarrierDecoder());
    }
    return Truck(id, status, manufacturer, common, carrier, motor, vin, maintenance, insurance, statusNavigation, manufacturerNavigation, truckCommonNavigation, maintenanceNavigation, insuranceNavigation, carrierNavigation, plates);
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
    List<Plate>? plates
  }){
    
    // If the field is setted via catalogs, then the pointers must be setted null when index is 0
    Manufacturer? manufacturerNav = manufacturerNavigation ?? this.manufacturerNavigation;
    if(manufacturer == 0) manufacturerNav = null;
    
    return Truck(id ?? this.id, status ?? this.status, manufacturer ?? this.manufacturer, common ?? this.common, carrier ?? this.carrier, motor ?? this.motor, vin ?? this.vin, maintenance ?? this.maintenance, 
    insurance ?? this.insurance, statusNavigation ?? this.statusNavigation, manufacturerNav, truckCommonNavigation ?? this.truckCommonNavigation, 
    maintenanceNavigation ?? this.maintenanceNavigation, insuranceNavigation ?? this.insuranceNavigation, carrierNavigation ?? this.carrierNavigation, plates ?? this.plates);
  }
  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
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
    if(vin.length != 17) results.add(CSMSetValidationResult(kVin, 'VIN number must be 17 length', 'strictLength(17)'));
    if(motor.length < 15 && motor.length > 16) results.add(CSMSetValidationResult(kMotor, 'Motor number must be between 15 and 16 length', 'strictLength(15,16)'));
    if(manufacturer < 0) results.add(CSMSetValidationResult(kManufacturer, 'Manufactuer pointer must be equal or greater than 0', 'pointerHandler()'));
    if(carrier < 0) results.add(CSMSetValidationResult(kCarrier, 'Carrier pointer must be equal or greater than 0', 'pointerHandler()'));
    if(manufacturer > 0 && manufacturerNavigation != null){
      if(manufacturer != manufacturerNavigation!.id) results.add(CSMSetValidationResult("[$kManufacturer, $kManufacturerNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 

    if(manufacturer  == 0 && manufacturerNavigation == null) results.add(CSMSetValidationResult("[$kManufacturer, $kManufacturerNavigation]", 'Required Manufacturer. Must be one Manufacturer insertion property', 'requiredInsertion()'));
    
    if((manufacturer != 0 && manufacturerNavigation != null) && (manufacturerNavigation!.id != manufacturer)) results.add(CSMSetValidationResult("[$kManufacturer, $kManufacturerNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));

    
    if(maintenance != null && maintenanceNavigation != null){
      if(maintenance != 0 && (maintenanceNavigation!.id != maintenance)) results.add(CSMSetValidationResult("[$kMaintenance, $kMaintenanceNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 
    if(insurance != null && insuranceNavigation != null){
      if(insurance != 0 && (insuranceNavigation!.id != insurance)) results.add(CSMSetValidationResult("[$kInsurance, $kInsurance]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 

    if(maintenance != null && maintenance! < 0) results.add(CSMSetValidationResult(kMaintenance, 'Maintenance pointer must be equal or greater than 0', 'pointerHandler()'));
    if(insurance != null && insurance! < 0) results.add(CSMSetValidationResult(kInsurance, 'Insurance pointer must be equal or greater than 0', 'pointerHandler()'));
  
    //Models validations 
    if(manufacturerNavigation != null) results = <CSMSetValidationResult>[...results, ...manufacturerNavigation!.evaluate()];
    if(maintenanceNavigation != null) results = <CSMSetValidationResult>[...results, ...maintenanceNavigation!.evaluate()];
    if(insuranceNavigation != null) results = <CSMSetValidationResult>[...results, ...insuranceNavigation!.evaluate()];
    
    if(plates.length != 2) results.add(CSMSetValidationResult(kPlates, 'Plates list must contain 2 objects', 'listLength(2)'));
    for(Plate plate in plates){
      results = <CSMSetValidationResult>[...results, ...plate.evaluate()];
    }
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
