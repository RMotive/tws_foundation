import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Truck implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kModel = 'model';
  static const String kCommon = 'common';
  static const String kCarrier = 'carrier';
  static const String kMotor = 'motor';
  static const String kVin = "vin";
  static const String kSct = "sct";
  static const String kMaintenance = 'maintenance';
  static const String kInsurance = 'insurance';
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kVehiculeModelNavigation = 'VehiculeModelNavigation';
  static const String kTruckCommonNavigation = 'TruckCommonNavigation';
  static const String kMaintenanceNavigation = 'MaintenanceNavigation';
  static const String kInsuranceNavigation = 'InsuranceNavigation';
  static const String kSctNavigation = "SctNavigation";
  static const String kCarrierNavigation = 'CarrierNavigation';
  static const String kPlates = 'plates';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  int model = 0;
  int common = 0;
  int carrier = 0;
  String vin = "";
  String? motor = '';
  int? maintenance;
  int? insurance;
  int? sct = 0;
  Status? statusNavigation;
  TruckCommon? truckCommonNavigation;
  VehiculeModel? vehiculeModelNavigation;
  Maintenance? maintenanceNavigation;
  Insurance? insuranceNavigation;
  SCT? sctNavigation;
  Carrier? carrierNavigation;

  // List default initialization data for clone method.
  List<Plate> plates = <Plate>[
    Plate.def(),
    Plate.def()
  ];

  Truck.def();

  Truck(this.id, this.status, this.model, this.common, this.carrier, this.motor, this.vin, this.maintenance, this.insurance, this.sct, this.statusNavigation, this.vehiculeModelNavigation, this.truckCommonNavigation, this.maintenanceNavigation,
    this.insuranceNavigation, this.sctNavigation ,this.carrierNavigation, this.plates, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Truck.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int model = json.get('model');
    int common = json.get('common');
    int carrier = json.get('carrier');
    String vin = json.get('vin');
    String? motor = json.getDefault('motor', null);
    DateTime timestamp = json.get('timestamp');
    int? maintenance = json.getDefault('maintenance', null);
    int? insurance = json.getDefault('insurance', null);
    int? sct = json.getDefault('sct', null);
    Status? statusNavigation;
    TruckCommon? truckCommonNavigation;
    VehiculeModel? vehiculeModelNavigation;
    Maintenance? maintenanceNavigation;
    Insurance? insuranceNavigation;
    SCT? sctNavigation;
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

    if (json['VehiculeModelNavigation'] != null) {
      JObject rawNavigation = json.getDefault('VehiculeModelNavigation', <String, dynamic>{});
      vehiculeModelNavigation = deserealize<VehiculeModel>(rawNavigation, decode: VehiculeModelDecoder());
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

    if (json['SctNavigation'] != null) {
      JObject rawNavigation = json.getDefault('SctNavigation', <String, dynamic>{});
      sctNavigation = deserealize<SCT>(rawNavigation, decode: SCTDecoder());
    }
    return Truck(id, status, model, common, carrier, motor, vin, maintenance, insurance, sct, statusNavigation, vehiculeModelNavigation, truckCommonNavigation, maintenanceNavigation, insuranceNavigation, sctNavigation, carrierNavigation, plates, timestamp: timestamp);
  }
  Truck clone({
    int? id,
    int? status,
    int? model,
    String? motor,
    String? vin,
    int? maintenance,
    int? common,
    int? carrier,
    int? insurance,
    int? sct,
    Status? statusNavigation,
    VehiculeModel? vehiculeModelNavigation,
    TruckCommon? truckCommonNavigation,
    Maintenance? maintenanceNavigation,
    Insurance? insuranceNavigation,
    SCT? sctNavigation,
    Carrier? carrierNavigation,
    List<Plate>? plates
  }){
    //Motor null validation
    //sct null validation
    // If the field is setted via catalogs, then the pointers must be setted null when index is 0
    VehiculeModel? vehiculeNav = vehiculeModelNavigation ?? this.vehiculeModelNavigation;
    if(model == 0) vehiculeNav = null;
    
    return Truck(id ?? this.id, status ?? this.status, model ?? this.model, common ?? this.common, carrier ?? this.carrier, motor ?? this.motor, vin ?? this.vin, maintenance ?? this.maintenance, 
    insurance ?? this.insurance, sct ?? this.sct, statusNavigation ?? this.statusNavigation, vehiculeNav, truckCommonNavigation ?? this.truckCommonNavigation, 
    maintenanceNavigation ?? this.maintenanceNavigation, insuranceNavigation ?? this.insuranceNavigation, sctNavigation ?? this.sctNavigation, carrierNavigation ?? this.carrierNavigation, plates ?? this.plates);
  }
  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kModel: model,
      kCommon: common,
      kCarrier: carrier,
      kMotor: motor,
      kVin: vin,
      kMaintenance: maintenance,
      kInsurance: insurance,
      kSct: sct,
      kTimestamp: timestamp.toIso8601String(),
      kstatusNavigation: statusNavigation?.encode(),
      kVehiculeModelNavigation: vehiculeModelNavigation?.encode(),
      kTruckCommonNavigation: truckCommonNavigation?.encode(),
      kMaintenanceNavigation: maintenanceNavigation?.encode(),
      kInsuranceNavigation: insuranceNavigation?.encode(),
      kSctNavigation: sctNavigation?.encode(),
      kCarrierNavigation: carrierNavigation?.encode(),
      kPlates: plates.map((Plate i) => i.encode()).toList()
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(vin.length != 17) results.add(CSMSetValidationResult(kVin, 'VIN number must be 17 length', 'strictLength(17)'));
    if(motor != null){
      if(motor!.length < 15 && motor!.length > 16) results.add(CSMSetValidationResult(kMotor, 'Motor number must be between 15 and 16 length', 'strictLength(15,16)'));
    }
    if(model < 0) results.add(CSMSetValidationResult(kModel, 'Manufactuer pointer must be equal or greater than 0', 'pointerHandler()'));
    if(carrier < 0) results.add(CSMSetValidationResult(kCarrier, 'Carrier pointer must be equal or greater than 0', 'pointerHandler()'));
    if(sct != null && sct! < 0) results.add(CSMSetValidationResult(kSct, 'SCT pointer must be equal or greater than 0', 'pointerHandler()'));

    if(model > 0 && vehiculeModelNavigation != null){
      if(model != vehiculeModelNavigation!.id) results.add(CSMSetValidationResult("[$kModel, $kVehiculeModelNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 

    if(model  == 0 && vehiculeModelNavigation == null) results.add(CSMSetValidationResult("[$kModel, $kVehiculeModelNavigation]", 'Required Manufacturer. Must be one Manufacturer insertion property', 'requiredInsertion()'));
    
    if((model != 0 && vehiculeModelNavigation != null) && (vehiculeModelNavigation!.id != model)) results.add(CSMSetValidationResult("[$kModel, $kVehiculeModelNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));

    
    if(maintenance != null && maintenanceNavigation != null){
      if(maintenance != 0 && (maintenanceNavigation!.id != maintenance)) results.add(CSMSetValidationResult("[$kMaintenance, $kMaintenanceNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 
    if(insurance != null && insuranceNavigation != null){
      if(insurance != 0 && (insuranceNavigation!.id != insurance)) results.add(CSMSetValidationResult("[$kInsurance, $kInsurance]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 
    if(sct != null && sctNavigation != null){
      if(sct != 0 && (sctNavigation!.id != sct)) results.add(CSMSetValidationResult("[$kSct, $kSctNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 
    
    // if((usdot == null && usdotNavigation == null) && (sct == null && sctNavigation == null)) results.add(CSMSetValidationResult("[$usdot, $sct]", 'Missing pointers. at least SCT or USDOT property must be set', 'missingProperty()'));

    if(sctNavigation != null) results = <CSMSetValidationResult>[...results, ...sctNavigation!.evaluate()];   
    if(carrierNavigation != null) results = <CSMSetValidationResult>[...results, ...carrierNavigation!.evaluate()]; 
    if(truckCommonNavigation != null) results = <CSMSetValidationResult>[...results, ...truckCommonNavigation!.evaluate()]; 
    if(maintenance != null && maintenance! < 0) results.add(CSMSetValidationResult(kMaintenance, 'Maintenance pointer must be equal or greater than 0', 'pointerHandler()'));
    if(insurance != null && insurance! < 0) results.add(CSMSetValidationResult(kInsurance, 'Insurance pointer must be equal or greater than 0', 'pointerHandler()'));
    
    //Models validations 
    if(vehiculeModelNavigation != null) results = <CSMSetValidationResult>[...results, ...vehiculeModelNavigation!.evaluate()];
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
