import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerExternal implements CSMSetInterface {
  static const String kCommon = "common";
  static const String kCarrier = "carrier";
  static const String kMxPlate = "mxPlate";
  static const String kUsaPlate = "usaPlate";
  static const String kTrailerCommonNavigation = 'TrailerCommonNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 
  
  TrailerExternal.a(){
    _timestamp = DateTime.now();
  }

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
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int common = json.get(kCommon);
    String carrier = json.get(kCarrier);
    String? mxPlate = json.getDefault(kMxPlate, null);
    DateTime timestamp = json.get(SCK.kTimestamp);
    String? usaPlate = json.getDefault(kUsaPlate, null);
    TrailerCommon? trailerCommonNavigation;

    if (json[kTrailerCommonNavigation] != null) {
      JObject rawNavigation = json.getDefault(kTrailerCommonNavigation, <String, dynamic>{});
      trailerCommonNavigation = TrailerCommon.des(rawNavigation);
    }

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
        
    return TrailerExternal(id, status, common, carrier, mxPlate, usaPlate, trailerCommonNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kCommon: common,
      kCarrier:carrier,
      kMxPlate: mxPlate,
      kUsaPlate: usaPlate,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kTrailerCommonNavigation: trailerCommonNavigation?.encode(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    bool isPlate = false;
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
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
    }else{
      if(common == 0) results.add(CSMSetValidationResult(kCommon, "Debe agregar el numero economico del trailer. Common data not founded.", "pointerHandle()"));
    }
    return results;
  }
  TrailerExternal clone({
    int? id,
    int? status,
    int? common,
    String? carrier,
    String? mxPlate,
    String? usaPlate,
    TrailerCommon? trailerCommonNavigation,
    Status? statusNavigation,
  }) {
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
