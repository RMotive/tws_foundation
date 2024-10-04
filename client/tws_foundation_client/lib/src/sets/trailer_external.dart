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
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(carrier.isEmpty || carrier.length > 100) results.add(CSMSetValidationResult(kCarrier, "Carrier length must be between 1 and 100", "strictLength(1, 100)"));

    if(mxPlate == null && usaPlate == null) results.add(CSMSetValidationResult(kMxPlate, "Debe agregar alguna placa al remolque externo.", "fieldConflict()"));

    if(mxPlate != null){
      if(mxPlate!.length < 8 || mxPlate!.length > 12) results.add(CSMSetValidationResult(kMxPlate, "MxPlate length must be between 8 and 12", "strictLength(1, 12)"));
    }
    if(usaPlate != null){
      if(usaPlate!.length < 8 || usaPlate!.length > 12) results.add(CSMSetValidationResult(kUsaPlate, "USA Plate length must be between 8 and 12", "strictLength(1, 12)"));
    }

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
    if(usaPlate == ""){
      uPlate = null;
    }
    String? mPlate = mxPlate ?? this.mxPlate;
    if(mxPlate == ""){
      mPlate = null;
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
