import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kClass = "class";
  static const String kSituation = "situation";
  static const String kLocation = "location";
  static const String kEconomic = "economic";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  int? trailerClass = 0;
  int? situation = 0;
  int? location;
  String economic = "";
  Status? statusNavigation;

  TrailerCommon(this.id, this.status, this.trailerClass, this.situation, this.location, this.economic, this.statusNavigation);

  TrailerCommon.a();

  factory TrailerCommon.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    int? trailerClass = json.getDefault(kClass, null);
    int? situation = json.getDefault(kSituation, null);
    int? location = json.getDefault(kLocation, null);
    String economic = json.get(kEconomic);

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    return TrailerCommon(id, status, trailerClass, situation, location, economic, statusNavigation);
  }

  TrailerCommon clone({
    int? id,
    int? status,
    int? trailerClass,
    int? situation,
    int? location,
    String? economic,
    Status? statusNavigation,
  }) {
    return TrailerCommon(
      id ?? this.id,
      status ?? this.status,
      trailerClass ?? this.trailerClass,
      situation ?? this.situation,
      location ?? this.location,
      economic ?? this.economic,
      statusNavigation ?? this.statusNavigation,
    );
  }

  @override
  JObject encode() {
    final Map<String, dynamic>? encStatus = statusNavigation?.encode();

    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kClass: trailerClass,
      kSituation: situation,
      kLocation: location,
      kEconomic: economic,
      kstatusNavigation: encStatus,
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (economic.length < 8 || economic.length > 12) results.add(CSMSetValidationResult(kEconomic, "Economic number length must be between 1 and 16", "strictLength(1,16)"));
    if (status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
}
