import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriverCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kLicense = "license";
  static const String kSituation = "situation";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 0;
  String license = "";
  int situation = 0;
  Status? statusNavigation;

  DriverCommon(this.id, this.status, this.license, this.situation, this.statusNavigation);
  factory DriverCommon.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    String license = json.get('license');
    int situation = json.get('situation');
    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
        
    return DriverCommon(id, status, license, situation, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kLicense: license,
      kSituation: situation,
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(license.length < 8 || license.length > 12) results.add(CSMSetValidationResult(kLicense, "license number length must be between 8 and 12", "strictLength(8,12)"));
    if(situation < 0) results.add(CSMSetValidationResult(kSituation, 'Situation pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  DriverCommon.def();
  DriverCommon clone({
    int? id,
    int? status,
    String? license,
    int? situation,
    Status? statusNavigation,
  }){
    return DriverCommon(id ?? this.id, status ?? this.status, license ?? this.license, situation ?? this.situation, statusNavigation ?? this.statusNavigation);
  }
}

final class DriverCommonDecoder implements CSMDecodeInterface<DriverCommon> {
  const DriverCommonDecoder();

  @override
  DriverCommon decode(JObject json) {
    return DriverCommon.des(json);
  }
}
