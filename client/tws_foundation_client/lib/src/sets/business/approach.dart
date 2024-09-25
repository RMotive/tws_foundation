import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Alternative contacts information, handles alternative contact information.
final class Approach implements CSMSetInterface {
  /// [status] property key.
  static const String kStatus = "status";

  /// [email] property key.
  static const String kEmail = "email";

  /// [enterprise] property key.
  static const String kEnterprise = "enterprise";

  /// [personal] property key.
  static const String kPersonal = "personal";

  /// [alternative] property key.
  static const String kAlternative = "alternative";

  /// [statusNavigation] property key.
  static const String kstatusNavigation = 'StatusNavigation';

  /// [carriers] property key.
  static const String kCarriers = "Carriers";

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreign relation [Status] pointer.
  int status = 1;

  /// Alternative contact email.
  String email = "";

  /// Alternative contact enterprise.
  String? enterprise = "";

  /// Alternative contact personal.
  String? personal = "";

  /// Alternative contact alternative.
  String? alternative = "";

  /// Alternative contact [Status] object.
  Status? statusNavigation;

  /// List of carriers with the current alternative information related.
  List<Carrier> carriers = <Carrier>[];

  /// Creates an [Approach] object with required properties.
  Approach(this.id, this.status, this.email, this.enterprise, this.personal, this.alternative, this.statusNavigation, this.carriers);

  /// Creates an [Approach] object with default properties.
  Approach.def();

  /// Creates an [Approach] object based on a [json] object.
  factory Approach.des(JObject json) {
    List<Carrier> carriers = <Carrier>[];
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    String email = json.get(kEmail);
    String? enterprise = json.getDefault(kEnterprise, null);
    String? personal = json.getDefault(kPersonal, null);
    String? alternative = json.getDefault(kPersonal, null);

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    List<JObject> rawCarriersArray = json.getList(kCarriers);
    carriers = rawCarriersArray
        .map<Carrier>(
          (JObject json) => Carrier.des(json),
        )
        .toList();

    return Approach(id, status, email, enterprise, personal, alternative, statusNavigation, carriers);
  }

  /// Creates an [Approach] object overriding the given properties.
  Approach clone({
    int? id,
    int? status,
    String? email,
    String? enterprise,
    String? personal,
    String? alternative,
    Status? statusNavigation,
    List<Carrier>? carriers,
  }) {
    return Approach(
      id ?? this.id,
      status ?? this.status,
      email ?? this.email,
      enterprise ?? this.enterprise,
      personal ?? this.personal,
      alternative ?? this.alternative,
      statusNavigation ?? this.statusNavigation,
      carriers ?? this.carriers,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kEmail: email,
      kEnterprise: enterprise,
      kPersonal: personal,
      kAlternative: alternative,
      kstatusNavigation: statusNavigation?.encode(),
      kCarriers: carriers.map((Carrier i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (email.length > 30) results.add(CSMSetValidationResult(kEmail, "Email must be 30  max length", "strictLength(1, 30)"));
    if (enterprise != null && enterprise!.length < 10 || enterprise!.length > 14) {
      results.add(CSMSetValidationResult(kEnterprise, "Enterprise number length must be between 10 and 14", "strictLength(10, 14)"));
    }
    if (personal != null && personal!.length < 10 || personal!.length > 14) results.add(CSMSetValidationResult(kPersonal, "Personal number length must be between 10 and 14", "strictLength(1,4)"));
    if (alternative != null && alternative!.length > 30) results.add(CSMSetValidationResult(kAlternative, "Alternative contact must be 30  max length", "strictLength(0, 30)"));

    return results;
  }
}
