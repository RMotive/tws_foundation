import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerExternal implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCommon = "common";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTrailerCommonNavigation = 'TrailerCommonNavigation';


  @override
  int id = 0;
  int status = 1;
  int common = 0;
  TrailerCommon? trailerCommonNavigation;
  Status? statusNavigation;

  TrailerExternal(this.id, this.status, this.common, this.trailerCommonNavigation, this.statusNavigation);
  factory TrailerExternal.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int common = json.get('common');

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
        
    return TrailerExternal(id, status, common, trailerCommonNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kCommon: common,
      kTrailerCommonNavigation: trailerCommonNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  TrailerExternal.def();
  TrailerExternal clone({
    int? id,
    int? status,
    int? common,
    TrailerCommon? trailerCommonNavigation,
    Status? statusNavigation,
  }){
    return TrailerExternal(id ?? this.id, status ?? this.status, common ?? this.common, trailerCommonNavigation ?? this.trailerCommonNavigation, statusNavigation ?? this.statusNavigation);
  }
}

final class TrailerExternalDecoder implements CSMDecodeInterface<TrailerExternal> {
  const TrailerExternalDecoder();

  @override
  TrailerExternal decode(JObject json) {
    return TrailerExternal.des(json);
  }
}
