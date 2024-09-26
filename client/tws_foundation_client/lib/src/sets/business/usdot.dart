import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Government Mexico permit for lofistic activities information, handling information related to a government permit and identification.
final class USDOT implements CSMSetInterface {
  /// [status] property key.
  static const String kStatus = "status";

  /// [mc] property key.
  static const String kMc = "mc";

  /// [scac] property key.
  static const String kScac = "number";

  /// [statusNavigation] property key.
  static const String kstatusNavigation = 'StatusNavigation';

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreign relation [Status] pointer.
  int status = 1;

  /// Identification number for permit.
  String mc = "";

  /// Alternative identification number for permit.
  String scac = "";

  /// Foreign relation [Status] object.
  Status? statusNavigation;

  /// Create an [USDOT] object with required properties.
  USDOT(this.id, this.status, this.mc, this.scac, this.statusNavigation);

  /// Creates an [USDOT] object with default properties.
  USDOT.a();

  /// Creates an [USDOT] object based on a given [json] object.
  factory USDOT.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    String mc = json.get(kMc);
    String scac = json.get(kScac);
    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    return USDOT(id, status, mc, scac, statusNavigation);
  }

  /// Creates an [USDOT] object overriding the given properties.
  USDOT clone({
    int? id,
    int? status,
    String? mc,
    String? scac,
    Status? statusNavigation,
  }) {
    return USDOT(
      id ?? this.id,
      status ?? this.status,
      mc ?? this.mc,
      scac ?? this.scac,
      statusNavigation ?? this.statusNavigation,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kMc: mc,
      kScac: scac,
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (mc.length != 7) results.add(CSMSetValidationResult(kMc, "MC number must be 7 length", "strictLength(7)"));
    if (scac.length != 4) results.add(CSMSetValidationResult(kScac, "SCAC number must be 4 length", "structLength(4)"));

    return results;
  }
}
