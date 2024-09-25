import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TruckExternal implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCommon = "common";
  static const String kVin = "vin";
  static const String kCarrier = "carrier";
  static const String kMxPlate = "mxPlate";
  static const String kUsaPlate = "usaPlate";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTruckCommonNavigation = 'TruckCommonNavigation';


  @override
  int id = 0;
  int status = 1;
  int common = 0;
  String? vin;
  String carrier = "";
  String mxPlate = "";
  String? usaPlate;
  TruckCommon? truckCommonNavigation;
  Status? statusNavigation;

  TruckExternal(this.id, this.status, this.common, this.vin, this.carrier, this.mxPlate, this.usaPlate, this.truckCommonNavigation, this.statusNavigation);
  factory TruckExternal.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int common = json.get('common');
    String? vin = json.getDefault("vin", null);
    String carrier = json.get('carrier');
    String mxPlate = json.get('mxPlate');
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
        
    return TruckExternal(id, status, common,  vin, carrier, mxPlate, usaPlate, truckCommonNavigation, statusNavigation);
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
      kTruckCommonNavigation: truckCommonNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(carrier.isEmpty || mxPlate.length > 100) results.add(CSMSetValidationResult(kCarrier, "Carrier length must be between 1 and 100", "strictLength(1, 100)"));
    if(mxPlate.length < 8 || mxPlate.length > 12) results.add(CSMSetValidationResult(kMxPlate, "MxPlate length must be between 8 and 12", "strictLength(1, 32)"));
    if(vin != null){
      if(vin!.length != 17) results.add(CSMSetValidationResult(kVin, 'VIN number must be 17 length', 'strictLength(17)'));
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
    if(usaPlate == ""){
      uPlate = null;
    }
    String? v = vin ?? this.vin;
    if(v == "") v = null;
    
    return TruckExternal(id ?? this.id, status ?? this.status, common ?? this.common, vin, carrier ?? this.carrier, mxPlate ?? this.mxPlate, uPlate, truckCommonNavigation ?? this.truckCommonNavigation, statusNavigation ?? this.statusNavigation);
  }
}

final class TruckExternalDecoder implements CSMDecodeInterface<TruckExternal> {
  const TruckExternalDecoder();

  @override
  TruckExternal decode(JObject json) {
    return TruckExternal.des(json);
  }
}
