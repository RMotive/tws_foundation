import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Common [Truck] information, handles information shared along Internal and External [Truck]s.
final class TruckCommon implements CSMSetInterface {
  /// [status] property key.
  static const String kStatus = "status";

  /// [economic] property key.
  static const String kEconomic = "economic";

  /// [location] property key.
  static const String kLocation = "location";

  /// [situation] property key.
  static const String kSituation = "situation";

  /// [statusNavigation] property key.
  static const String kstatusNavigation = 'StatusNavigation';

  /// [situationNavigation] property key.
  static const String kSituationNavigation = 'SituationNavigation';

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreign relation [Status] pointer.
  int status = 1;

  /// [Truck] economic label identification.
  String economic = "";

  /// Foreign relation [Location] pointer.
  int? location = 0;

  /// Foreign relation [Situation] pointer.
  int? situation = 0;

  /// Foreign relation [Situation] object.
  Situation? situationNavigation;

  /// Foreign relation [Status] object.
  Status? statusNavigation;

  /// Creates a [TruckCommon] object with required properties.
  TruckCommon(this.id, this.status, this.economic, this.location, this.situation, this.situationNavigation, this.statusNavigation);

  /// Creates a [TruckCommon] object with default properties.
  TruckCommon.a();

  /// Creates a [TruckCommon] object based on a given [json] object.
  factory TruckCommon.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    String economic = json.get(kEconomic);
    int? location = json.getDefault(kLocation, null);
    int? situation = json.getDefault(kSituation, null);

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    Situation? situationNavigation;
    if (json[kSituationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kSituationNavigation, <String, dynamic>{});
      situationNavigation = Situation.des(rawNavigation);
    }

    return TruckCommon(id, status, economic, location, situation, situationNavigation, statusNavigation);
  }

  /// Creates a [TruckCommon] object overriding given properties.
  TruckCommon clone({
    int? id,
    int? status,
    String? vin,
    String? economic,
    int? location,
    int? situation,
    Situation? situationNavigation,
    Status? statusNavigation,
  }) {
    int? situationIndex = situation ?? this.situation;
    Situation? situationNav = situationNavigation ?? this.situationNavigation;
    if (situationIndex == 0) {
      situationIndex = null;
      situationNav = null;
    }

    return TruckCommon(
      id ?? this.id,
      status ?? this.status,
      economic ?? this.economic,
      location ?? this.location,
      situation ?? this.situation,
      situationNav,
      statusNavigation ?? this.statusNavigation,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kEconomic: economic,
      kLocation: location,
      kSituation: situation,
      kSituationNavigation: situationNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode()
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (economic.isEmpty || economic.length > 16) results.add(CSMSetValidationResult(kEconomic, "Economic number length must be between 1 and 16", "strictLength(1,16)"));
    if (status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
}
