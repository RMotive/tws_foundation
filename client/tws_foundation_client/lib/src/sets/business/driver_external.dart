import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriverExternal implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kIdentification = "identification";
  static const String kCommon = "common";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kDriverCommonNavigation = 'DriverCommonNavigation';
  static const String kIdentificationNavigation = 'IdentificationNavigation';

  @override
  int id = 0;
  int status = 1;
  int identification = 0;
  int common = 0;
  DriverCommon? driverCommonNavigation;
  Identification? identificationNavigation;
  Status? statusNavigation;

  DriverExternal(this.id, this.status, this.identification, this.common, this.driverCommonNavigation, this.identificationNavigation, this.statusNavigation);

  DriverExternal.def();

  factory DriverExternal.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    int identification = json.get(kIdentification);
    int common = json.get(kCommon);

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    DriverCommon? driverCommonNavigation;
    if (json[kDriverCommonNavigation] != null) {
      JObject rawNavigation = json.getDefault(kDriverCommonNavigation, <String, dynamic>{});
      driverCommonNavigation = DriverCommon.des(rawNavigation);
    }

    Identification? identificationNavigator;
    if (json[kIdentificationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kIdentificationNavigation, <String, dynamic>{});
      identificationNavigator = Identification.des(rawNavigation);
    }

    return DriverExternal(id, status, identification, common, driverCommonNavigation, identificationNavigator, statusNavigation);
  }

  DriverExternal clone({
    int? id,
    int? status,
    int? identification,
    int? common,
    Identification? identificationNavigation,
    DriverCommon? driverCommonNavigation,
    Status? statusNavigation,
  }) {
    return DriverExternal(
      id ?? this.id,
      status ?? this.status,
      identification ?? this.identification,
      common ?? this.common,
      driverCommonNavigation ?? this.driverCommonNavigation,
      identificationNavigation ?? this.identificationNavigation,
      statusNavigation ?? this.statusNavigation,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kIdentification: identification,
      kCommon: common,
      kDriverCommonNavigation: driverCommonNavigation?.encode(),
      kIdentificationNavigation: identificationNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (identification < 0) results.add(CSMSetValidationResult(kIdentification, 'Identification pointer must be equal or greater than 0', 'pointerHandler()'));
    if (common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if (status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
}
