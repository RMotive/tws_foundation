import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriverCommon implements CSMSetInterface {
  static const String kLicense = "license";
  static const String kSituation = "situation";

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
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    String license = json.get(kLicense);
    int? situation = json.getDefault(kSituation, null);
    DateTime timestamp = json.get(SCK.kTimestamp);
    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
    
    return DriverCommon(id, status, license, situation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kLicense: license,
      kSituation: situation,
      SCK.kTimestamp: timestamp.toIso8601String(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(license.length < 8 || license.length > 12) results.add(CSMSetValidationResult(kLicense, "El numero de licencia debe tener un largo entre 8 y 12 caracteres.", "strictLength(8,12)"));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  DriverCommon.def();
  DriverCommon clone({
    int? id,
    int? status,
    String? license,
    int? situation,
    Status? statusNavigation,
  }) {
    int? sit = situation ?? this.situation;
    if (sit == 0) {
      sit = null;
    }
    return DriverCommon(
      id ?? this.id,
      status ?? this.status,
      license ?? this.license,
      sit,
      statusNavigation ?? this.statusNavigation,
    );
  }
}
