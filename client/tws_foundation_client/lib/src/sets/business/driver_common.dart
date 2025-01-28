import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriverCommon implements CSMSetInterface {
  
  /// [license] property key.
  static const String kLicense = "license";

  /// [situation] property key.
  static const String kSituation = "situation";
  
  /// [Situation] property key.
  static const String kSituationNavigation = "SituationNavigation";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Database record pointer.
  @override
  int id = 0;

  /// Foreign relationship [Status] pointer.
  int status = 1;

  /// Driver license number.
  String license = "";

  /// Foreign relationship [Situation] pointer.
  int? situation;

  /// [Status] navigation set.
  Status? statusNavigation;

  /// [Situation] navigation set.
  Situation? situationNavigation;

  /// Creates an [DriverCommon] object with default properties.
  DriverCommon.a();

  /// Creates an [DriverCommon] object with required properties.
  DriverCommon(this.id, this.status, this.license, this.situation, this.statusNavigation, this.situationNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates an [DriverCommon] object based on a serialized JSON object.
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

    Situation? situationNavigation;
    if (json[kSituationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kSituationNavigation, <String, dynamic>{});
      situationNavigation = Situation.des(rawNavigation);
    }
    
    return DriverCommon(id, status, license, situation, statusNavigation, situationNavigation, timestamp: timestamp);
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
      kSituationNavigation: situationNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(license.length < 8 || license.length > 12) results.add(CSMSetValidationResult(kLicense, "El numero de licencia debe tener un largo entre 8 y 12 caracteres.", "strictLength(8,12)"));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(situation != null && situation! < 0) results.add(CSMSetValidationResult(kSituation, 'Situation pointer must be empty, equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  /// Creates a copy from [DriverCommon] object. Overriding the given properties.
  DriverCommon clone({
    int? id,
    int? status,
    String? license,
    int? situation,
    Status? statusNavigation,
    Situation? situationNavigation,
  }) {
    
    if (situation == 0) {
      this.situation = null;
      this.situationNavigation = null;
      situationNavigation = null;
      situation = null;
    }

    return DriverCommon(
      id ?? this.id,
      status ?? this.status,
      license ?? this.license,
      situation ?? this.situation,
      statusNavigation ?? this.statusNavigation,
      situationNavigation ?? this.situationNavigation,
    );
  }
}
