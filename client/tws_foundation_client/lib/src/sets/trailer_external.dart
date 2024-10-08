import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerExternal implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCommon = "common";
  static const String kCarrier = "carrier";
  static const String kMxPlate = "mxPlate";
  static const String kUsaPlate = "usaPlate";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTrailerCommonNavigation = 'TrailerCommonNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  int common = 0;
  String carrier = "";
  String? mxPlate;
  String? usaPlate;
  TrailerCommon? trailerCommonNavigation;
  Status? statusNavigation;

  TrailerExternal(this.id, this.status, this.common, this.carrier, this.mxPlate, this.usaPlate, this.trailerCommonNavigation, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory TrailerExternal.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int common = json.get('common');
    String carrier = json.get('carrier');
    String? mxPlate = json.getDefault('mxPlate', null);
    DateTime timestamp = json.get('timestamp');
    String? usaPlate = json.getDefault('usaPlate', null);
    TrailerCommon? trailerCommonNavigation;

    if (json['TrailerCommonNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TrailerCommonNavigation', <String, dynamic>{});
      trailerCommonNavigation = deserealize<TrailerCommon>(rawNavigation, decode: TrailerCommonDecoder());
    }

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
        
    return TrailerExternal(id, status, common, carrier, mxPlate, usaPlate, trailerCommonNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kCommon: common,
      kCarrier:carrier,
      kMxPlate: mxPlate,
      kUsaPlate: usaPlate,
      kTimestamp: timestamp.toIso8601String(),
      kTrailerCommonNavigation: trailerCommonNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    bool isPlate = false;
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(carrier.trim().isEmpty || carrier.length > 100) results.add(CSMSetValidationResult(kCarrier, "Carrier length must be between 1 and 100", "strictLength(1, 100)"));

    if(mxPlate != null){
      if(mxPlate!.trim().isEmpty) results.add(CSMSetValidationResult(kMxPlate, "Elimine los espacios en blanco de las placas mexicanas en el trailer externo.", "emptyString()"));
      if((mxPlate!.length < 5 || mxPlate!.length > 12) && mxPlate!.trim().isNotEmpty){
        results.add(CSMSetValidationResult(kMxPlate, "Las placas mexicanas del remolque externo deben tener una longitud de entre 5 y 12 caracteres.", "strictLength(5, 12)"));
      }else{
        isPlate = true;
      }
    }
    if(usaPlate != null){
      if(usaPlate!.trim().isEmpty) results.add(CSMSetValidationResult(kUsaPlate, "Elimine los espacios en blanco de las placas americanas en el trailer externo.", "emptyString()"));
      if((usaPlate!.length < 5 || usaPlate!.length > 12) && usaPlate!.trim().isNotEmpty){
        results.add(CSMSetValidationResult(kUsaPlate, "Las placas americanas del remolque externo deben tener una longitud de entre 5 y 12 caracteres.", "strictLength(8, 12)"));
      }else{
        isPlate = true;
      }
    }
    if(!isPlate) results.add(CSMSetValidationResult(kMxPlate, "Debe agregar alguna placa al Remolque externo.", "fieldConflict()"));

    if(trailerCommonNavigation != null){
      results = <CSMSetValidationResult>[...results, ...trailerCommonNavigation!.evaluate()];
    }
    return results;
  }
  TrailerExternal.def();
  TrailerExternal clone({
    int? id,
    int? status,
    int? common,
    String? carrier,
    String? mxPlate,
    String? usaPlate,
    TrailerCommon? trailerCommonNavigation,
    Status? statusNavigation,
  }){
    String? uPlate = usaPlate ?? this.usaPlate;
    if(usaPlate != null){
      if(usaPlate.trim().isEmpty) uPlate = null;
    }
    String? mPlate = mxPlate ?? this.mxPlate;
    if(mxPlate != null){
      if(mxPlate.trim().isEmpty) mPlate = null;
    }
    return TrailerExternal(id ?? this.id, status ?? this.status, common ?? this.common, carrier ?? this.carrier, 
    mPlate, uPlate, trailerCommonNavigation ?? this.trailerCommonNavigation, statusNavigation ?? this.statusNavigation);
  }
}

final class TrailerExternalDecoder implements CSMDecodeInterface<TrailerExternal> {
  const TrailerExternalDecoder();

  @override
  TrailerExternal decode(JObject json) {
    return TrailerExternal.des(json);
  }
}
