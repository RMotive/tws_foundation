import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Truck implements CSMSetInterface {
  static const String kModel = 'model';
  static const String kCommon = 'common';
  static const String kCarrier = 'carrier';
  static const String kMotor = 'motor';
  static const String kVin = "vin";
  static const String kSct = "sct";
  static const String kMaintenance = 'maintenance';
  static const String kInsurance = 'insurance';
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
  int? sct;
  Status? statusNavigation;
  TruckCommon? truckCommonNavigation;
  VehiculeModel? vehiculeModelNavigation;
  Maintenance? maintenanceNavigation;
  Insurance? insuranceNavigation;
  SCT? sctNavigation;
  Carrier? carrierNavigation;
  List<Plate> plates = <Plate>[
    Plate.a()
  ];

  Truck.a(){
    _timestamp = DateTime.now();
  }

  Truck(this.id, this.status, this.model, this.common, this.carrier, this.motor, this.vin, this.maintenance, this.insurance, this.sct, this.statusNavigation, this.vehiculeModelNavigation, this.truckCommonNavigation, this.maintenanceNavigation,
    this.insuranceNavigation, this.sctNavigation ,this.carrierNavigation, this.plates, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Truck.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int model = json.get(kModel);
    int common = json.get(kCommon);
    int carrier = json.get(kCarrier);
    String vin = json.get(kVin);
    String? motor = json.getDefault(kMotor, null);
    DateTime timestamp = json.get(SCK.kTimestamp);
    int? maintenance = json.getDefault(kMaintenance, null);
    int? insurance = json.getDefault(kInsurance, null);
    int? sct = json.getDefault(kSct, null);
    Status? statusNavigation;
    TruckCommon? truckCommonNavigation;
    VehiculeModel? vehiculeModelNavigation;
    Maintenance? maintenanceNavigation;
    Insurance? insuranceNavigation;
    SCT? sctNavigation;
    Carrier? carrierNavigation;
    List<Plate> plates = <Plate>[];
    List<JObject> rawPlateArray = json.getList(kPlates);
    plates = rawPlateArray.map<Plate>(Plate.des).toList();

    //Optional parameters validation.
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    if (json[kTruckCommonNavigation] != null) {
      JObject rawNavigation = json.getDefault(kTruckCommonNavigation, <String, dynamic>{});
      truckCommonNavigation = TruckCommon.des(rawNavigation);
    }

    if (json[kVehiculeModelNavigation] != null) {
      JObject rawNavigation = json.getDefault(kVehiculeModelNavigation, <String, dynamic>{});
      vehiculeModelNavigation = VehiculeModel.des(rawNavigation);
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

    if (json[kSctNavigation] != null) {
      JObject rawNavigation = json.getDefault(kSctNavigation, <String, dynamic>{});
      sctNavigation = SCT.des(rawNavigation);
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
    if(motor != null){
      if(motor.trim().isEmpty){
        motor = null;
        this.motor = null;
      }
    }
    // --> Removing empty navigations content
    if(insuranceNavigation != null){
      if(insuranceNavigation.policy.trim().isEmpty && insuranceNavigation.expiration == DateTime(0) && insuranceNavigation.country.trim().isEmpty){
        this.insurance = null;
        this.insuranceNavigation = null;
        insurance = null;
        insuranceNavigation = null;
      }
    }
    if(maintenanceNavigation != null){
      if(maintenanceNavigation.trimestral == DateTime(0) && maintenanceNavigation.anual == DateTime(0)){
        this.maintenance = null;
        this.maintenanceNavigation = null;
        maintenance = null;
        maintenanceNavigation = null;
      }
    }

    if(sctNavigation != null){
      if(sctNavigation.configuration.trim().isEmpty && sctNavigation.number.trim().isEmpty && sctNavigation.type.trim().isEmpty){
        this.sct = null;
        this.sctNavigation = null;
        sct = null;
        sctNavigation = null;
      }
    }

    if(sct == 0){
      this.sct = null;
      this.sctNavigation = null;
      sct = null;
      sctNavigation = null;
    }
    if(insurance == 0){
      this.insurance = null;
      this.insuranceNavigation = null;
      insurance = null;
      insuranceNavigation = null;
    }
    if(maintenance == 0){
      this.maintenance = null;
      this.maintenanceNavigation = null;
      maintenance = null;
      maintenanceNavigation = null;
    }
    // If the field is setted via catalogs, then the pointers must be setted null when index is 0
    if(model == 0){
      this.vehiculeModelNavigation = null;
      vehiculeModelNavigation = null;
    }
    if(carrier == 0){
      this.carrierNavigation = null;
      carrierNavigation = null;
    }

    
    return Truck(id ?? this.id, status ?? this.status, model ?? this.model, common ?? this.common, carrier ?? this.carrier, motor ?? this.motor, vin ?? this.vin, maintenance ?? this.maintenance, 
    insurance ?? this.insurance, sct ?? this.sct, statusNavigation ?? this.statusNavigation, vehiculeModelNavigation ?? this.vehiculeModelNavigation, truckCommonNavigation ?? this.truckCommonNavigation, 
    maintenanceNavigation ?? this.maintenanceNavigation, insuranceNavigation ?? this.insuranceNavigation, sctNavigation ?? this.sctNavigation, carrierNavigation ?? this.carrierNavigation, plates ?? this.plates);
  }
  @override
  JObject encode() {
    // Avoiding EF tracking issues.
    JObject? carrierNav = carrierNavigation?.encode();
    if(carrier != 0) carrierNav = null;
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kModel: model,
      kCommon: common,
      kCarrier: carrier,
      kMotor: motor,
      kVin: vin,
      kMaintenance: maintenance,
      kInsurance: insurance,
      kSct: sct,
      SCK.kTimestamp: timestamp.toIso8601String(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
      kVehiculeModelNavigation: vehiculeModelNavigation?.encode(),
      kTruckCommonNavigation: truckCommonNavigation?.encode(),
      kMaintenanceNavigation: maintenanceNavigation?.encode(),
      kInsuranceNavigation: insuranceNavigation?.encode(),
      kSctNavigation: sctNavigation?.encode(),
      kCarrierNavigation: carrierNav,
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
    
    if(plates.isEmpty) results.add(CSMSetValidationResult(kPlates, 'Truck must have one plate at least', 'listLength()'));
    for(Plate plate in plates){
      results = <CSMSetValidationResult>[...results, ...plate.evaluate()];
    }
    return results;
  }
}
