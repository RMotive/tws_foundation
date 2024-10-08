import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriverCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kLicense = "license";
  static const String kSituation = "situation";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = 'StatusNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  String license = "";
  int? situation;
  Status? statusNavigation;

  DriverCommon(this.id, this.status, this.license, this.situation, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory DriverCommon.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    String license = json.get('license');
    int? situation = json.getDefault('situation', null);
    DateTime timestamp = json.get('timestamp');
    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
    
    return DriverCommon(id, status, license, situation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kLicense: license,
      kSituation: situation,
      kTimestamp: timestamp.toIso8601String(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(license.length < 8 || license.length > 12) results.add(CSMSetValidationResult(kLicense, "El numero de licencia debe tener un largo entre 8 y 12 caracteres.", "strictLength(8,12)"));
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
    int? sit = situation ?? this.situation;
    if(sit == 0){
      sit = null;
    }
    return DriverCommon(id ?? this.id, status ?? this.status, license ?? this.license, sit, statusNavigation ?? this.statusNavigation);
  }
}

final class DriverCommonDecoder implements CSMDecodeInterface<DriverCommon> {
  const DriverCommonDecoder();

  @override
  DriverCommon decode(JObject json) {
    return DriverCommon.des(json);
  }
}
