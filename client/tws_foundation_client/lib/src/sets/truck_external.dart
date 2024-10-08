import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TruckExternal implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCommon = "common";
  static const String kVin = "vin";
  static const String kCarrier = "carrier";
  static const String kMxPlate = "mxPlate";
  static const String kUsaPlate = "usaPlate";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTruckCommonNavigation = 'TruckCommonNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  int common = 0;
  String? vin;
  String carrier = "";
  String? mxPlate;
  String? usaPlate;
  TruckCommon? truckCommonNavigation;
  Status? statusNavigation;

  TruckExternal(this.id, this.status, this.common, this.vin, this.carrier, this.mxPlate, this.usaPlate, this.truckCommonNavigation, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory TruckExternal.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int common = json.get('common');
    String? vin = json.getDefault("vin", null);
    String carrier = json.get('carrier');
    String mxPlate = json.get('mxPlate');
    DateTime timestamp = json.get('timestamp');
    String? usaPlate = json.getDefault('usaPlate', null);
    TruckCommon? truckCommonNavigation;
    if (json['TruckCommonNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TruckCommonNavigation', <String, dynamic>{});
      truckCommonNavigation = deserealize<TruckCommon>(rawNavigation, decode: TruckCommonDecoder());
    }

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
        
    return TruckExternal(id, status, common,  vin, carrier, mxPlate, usaPlate, truckCommonNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kCommon: common,
      kVin: vin,
      kCarrier: carrier,
      kMxPlate: mxPlate,
      kUsaPlate: usaPlate,
      kTimestamp: timestamp.toIso8601String(),
      kTruckCommonNavigation: truckCommonNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    bool isPlate = false;
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    
    if(carrier.trim().isEmpty || carrier.length > 100) results.add(CSMSetValidationResult(kCarrier, "El nombre del transportista (Carrier) no debe estar vacio y debe tener maximo 100 caracteres", "strictLength(1, 100)"));

    if(mxPlate != null){
      if(mxPlate!.trim().isEmpty) results.add(CSMSetValidationResult(kMxPlate, "Elimine los espacios en blanco de las placas mexicanas en el trailer externo.", "emptyString()"));
      if((mxPlate!.length < 5 || mxPlate!.length > 12) && mxPlate!.trim().isNotEmpty){
        results.add(CSMSetValidationResult(kMxPlate, "Las placas mexicanas del camión externo deben tener una longitud de entre 5 y 12 caracteres.", "strictLength(5, 12)"));
      }else{
        isPlate = true;
      }
    }
    if(usaPlate != null){
      if(usaPlate!.trim().isEmpty) results.add(CSMSetValidationResult(kUsaPlate, "Elimine los espacios en blanco de las placas americanas en el trailer externo.", "emptyString()"));
      if((usaPlate!.length < 5 || usaPlate!.length > 12) && usaPlate!.trim().isNotEmpty){
        results.add(CSMSetValidationResult(kUsaPlate, "Las placas americanas del camión externo deben tener una longitud de entre 5 y 12 caracteres.", "strictLength(5, 12)"));
      }else{
        isPlate = true;
      }
    }
    if(!isPlate) results.add(CSMSetValidationResult(kMxPlate, "Debe agregar alguna placa al camión externo.", "fieldConflict()"));
    if(vin != null){
      if(vin!.length != 17 && vin!.isNotEmpty) results.add(CSMSetValidationResult(kVin, 'External Truck VIN number must be 17 length', 'strictLength(17)'));
    }

    if(truckCommonNavigation != null){
      results = <CSMSetValidationResult>[...results, ...truckCommonNavigation!.evaluate()];
    }else{
      if(common == 0) results.add(CSMSetValidationResult(kCommon, "Debe agregar el numero economico del camión. Common data not founded.", "pointerHandle()"));
    }
    return results;
  }
  TruckExternal.def();
  TruckExternal clone({
    int? id,
    int? status,
    int? common,
    String? vin,
    String? carrier,
    String? mxPlate,
    String? usaPlate,
    TruckCommon? truckCommonNavigation,
    Status? statusNavigation,
  }){
    String? uPlate = usaPlate ?? this.usaPlate;
    if(usaPlate != null){
      if(usaPlate.trim().isEmpty){
        uPlate = null;
      }
    }
    String? mPlate = mxPlate ?? this.mxPlate;
    if(mxPlate != null){
      if(mxPlate.trim().isEmpty){
        mPlate = null;
      }
    }
   
    String? v = vin ?? this.vin;
    if(v != null){
      if(v.trim().isEmpty) v = null;
    }

    return TruckExternal(id ?? this.id, status ?? this.status, common ?? this.common, vin, carrier ?? this.carrier, mPlate, uPlate, truckCommonNavigation ?? this.truckCommonNavigation, statusNavigation ?? this.statusNavigation);
  }
}

final class TruckExternalDecoder implements CSMDecodeInterface<TruckExternal> {
  const TruckExternalDecoder();

  @override
  TruckExternal decode(JObject json) {
    return TruckExternal.des(json);
  }
}
