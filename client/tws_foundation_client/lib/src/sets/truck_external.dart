import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TruckExternal implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCommon = "common";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTruckCommonNavigation = 'TruckCommonNavigation';


  @override
  int id = 0;
  int status = 0;
  int common = 0;
  TruckCommon? truckCommonNavigation;
  Status? statusNavigation;

  TruckExternal(this.id, this.status, this.common, this.truckCommonNavigation, this.statusNavigation);
  factory TruckExternal.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int common = json.get('common');

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
        
    return TruckExternal(id, status, common, truckCommonNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kCommon: common,
      kTruckCommonNavigation: truckCommonNavigation?.encode(),
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
  TruckExternal.def();
  TruckExternal clone({
    int? id,
    int? status,
    int? common,
    TruckCommon? truckCommonNavigation,
    Status? statusNavigation,
  }){
    return TruckExternal(id ?? this.id, status ?? this.status, common ?? this.common, truckCommonNavigation ?? this.truckCommonNavigation, statusNavigation ?? this.statusNavigation);
  }
}

final class TruckExternalDecoder implements CSMDecodeInterface<TruckExternal> {
  const TruckExternalDecoder();

  @override
  TruckExternal decode(JObject json) {
    return TruckExternal.des(json);
  }
}
