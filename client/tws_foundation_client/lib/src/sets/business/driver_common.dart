import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriverCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kLicense = "license";
  static const String kSituation = "situation";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  String license = "";
  int? situation;
  Status? statusNavigation;

  DriverCommon(this.id, this.status, this.license, this.situation, this.statusNavigation);

  DriverCommon.def();

  factory DriverCommon.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    String license = json.get(kLicense);
    int? situation = json.getDefault(kSituation, null);
    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    return DriverCommon(id, status, license, situation, statusNavigation);
  }

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

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kLicense: license,
      kSituation: situation,
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (license.length < 8 || license.length > 12) results.add(CSMSetValidationResult(kLicense, "license number length must be between 8 and 12", "strictLength(8,12)"));
    if (status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
}
