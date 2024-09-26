import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// SCT government logistical permit information, handles critical government permission information for logistic activities.
final class SCT implements CSMSetInterface {
  /// [status] property key.
  static const String kStatus = "status";

  /// [type] property key.
  static const String kType = "type";

  /// [number] property key.
  static const String kNumber = "number";

  /// [configuration] property key.
  static const String kConfiguration = "configuration";

  /// [statusNavigation] property key.
  static const String kstatusNavigation = 'StatusNavigation';

  /// [trucks] property key.
  static const String kTrucks = "trucks";

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreing relation [Status] pointer.
  int status = 1;

  /// Descriptive type of permit.
  String type = "";

  /// Identification number of permit.
  String number = "";

  /// Descriptive permit configuration.
  String configuration = "";

  /// Foreign relation [Status] object.
  Status? statusNavigation;

  /// List of [Truck] that holds the current [SCT] permit.
  List<Truck> trucks = <Truck>[];

  /// Creates a [SCT] object with required properties.
  SCT(this.id, this.status, this.type, this.number, this.configuration, this.statusNavigation, this.trucks);

  /// Creates a [SCT] object with default properties.
  SCT.a();

  /// Creates a [SCT] object based on the given [json] object.
  factory SCT.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    String type = json.get(kType);
    String number = json.get(kNumber);
    String configuration = json.get(kConfiguration);

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    List<JObject> rawTrucksArray = json.getList(kTrucks);
    trucks = rawTrucksArray
        .map<Truck>(
          (JObject json) => Truck.des(json),
        )
        .toList();

    return SCT(id, status, type, number, configuration, statusNavigation, trucks);
  }

  /// Creates a [SCT] object overriding given properties.
  SCT clone({
    int? id,
    int? status,
    String? type,
    String? number,
    String? configuration,
    Status? statusNavigation,
    List<Truck>? trucks,
  }) {
    return SCT(
      id ?? this.id,
      status ?? this.status,
      type ?? this.type,
      number ?? this.number,
      configuration ?? this.configuration,
      statusNavigation ?? this.statusNavigation,
      trucks ?? this.trucks,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kType: type,
      kNumber: number,
      kConfiguration: configuration,
      kstatusNavigation: statusNavigation?.encode(),
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (type.length != 6) results.add(CSMSetValidationResult(kType, "Type must be 6 length", "strictLength(6)"));
    if (number.length != 25) results.add(CSMSetValidationResult(kNumber, "Number must be 25 length", "structLength(25)"));
    if (configuration.length < 6 || configuration.length > 10) results.add(CSMSetValidationResult(kConfiguration, "Configuration must be between 6 and 10 length", "strictLength(6,10)"));

    return results;
  }
}
