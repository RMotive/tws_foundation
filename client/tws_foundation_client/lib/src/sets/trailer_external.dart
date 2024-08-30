import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerExternal implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCommon = "common";
  static const String kMxPlate = "mxPlate";
  static const String kUsaPlate = "usaPlate";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTrailerCommonNavigation = 'TrailerCommonNavigation';


  @override
  int id = 0;
  int status = 1;
  int common = 0;
  String mxPlate = "";
  String? usaPlate;
  TrailerCommon? trailerCommonNavigation;
  Status? statusNavigation;

  TrailerExternal(this.id, this.status, this.common, this.mxPlate, this.usaPlate, this.trailerCommonNavigation, this.statusNavigation);
  factory TrailerExternal.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int common = json.get('common');
    String mxPlate = json.get('mxPlate');
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
        
    return TrailerExternal(id, status, common, mxPlate, usaPlate, trailerCommonNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kCommon: common,
      kMxPlate: mxPlate,
      kUsaPlate: usaPlate,
      kTrailerCommonNavigation: trailerCommonNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(mxPlate.length < 8 || mxPlate.length > 12) results.add(CSMSetValidationResult(kMxPlate, "MxPlate length must be between 8 and 12", "strictLength(1, 32)"));

    return results;
  }
  TrailerExternal.def();
  TrailerExternal clone({
    int? id,
    int? status,
    int? common,
    String? mxPlate,
    String? usaPlate,
    TrailerCommon? trailerCommonNavigation,
    Status? statusNavigation,
  }){
    String? uPlate = usaPlate ?? this.usaPlate;
    if(usaPlate == ""){
      uPlate = null;
    }
    return TrailerExternal(id ?? this.id, status ?? this.status, common ?? this.common, mxPlate ?? this.mxPlate, uPlate, trailerCommonNavigation ?? this.trailerCommonNavigation, statusNavigation ?? this.statusNavigation);
  }
}

final class TrailerExternalDecoder implements CSMDecodeInterface<TrailerExternal> {
  const TrailerExternalDecoder();

  @override
  TrailerExternal decode(JObject json) {
    return TrailerExternal.des(json);
  }
}
