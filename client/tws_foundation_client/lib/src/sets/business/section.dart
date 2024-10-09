import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Section implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kYard = "yard";
  static const String kCapacity = "capacity";
  static const String kOcupancy = "ocupancy";
  static const String kLocationNavigation = "LocationNavigation";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  int yard = 0;
  String name = "";
  int capacity = 0;
  int ocupancy = 0;
  Location? locationNavigation;
  Status? statusNavigation;

  Section(this.id, this.status, this.yard, this.name, this.capacity, this.ocupancy, this.locationNavigation, this.statusNavigation);

  Section.a();

  factory Section.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    int yard = json.get(kYard);
    String name = json.get(SCK.kName);
    int capacity = json.get(kCapacity);
    int ocupancy = json.get(kOcupancy);

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    Location? locationNavigation;
    if (json[kLocationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kLocationNavigation, <String, dynamic>{});
      locationNavigation = Location.des(rawNavigation);
    }

    return Section(id, status, yard, name, capacity, ocupancy, locationNavigation, statusNavigation);
  }

  Section clone({
    int? id,
    int? status,
    int? yard,
    String? name,
    int? capacity,
    int? ocupancy,
    Location? locationNavigation,
    Status? statusNavigation,
  }) {
    return Section(
      id ?? this.id,
      status ?? this.status,
      yard ?? this.yard,
      name ?? this.name,
      capacity ?? this.capacity,
      ocupancy ?? this.ocupancy,
      locationNavigation ?? this.locationNavigation,
      statusNavigation ?? this.statusNavigation,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kName: name,
      kStatus: status,
      kYard: yard,
      kCapacity: capacity,
      kOcupancy: ocupancy,
      kLocationNavigation: locationNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (name.isEmpty || name.length > 30) results.add(CSMSetValidationResult(SCK.kName, "Name must be 25 max lenght and non-empty", "strictLength(1,30)"));
    if (yard < 0) results.add(CSMSetValidationResult(kYard, 'Yard pointer must be equal or greater than 0', 'pointerHandler()'));
    if (status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
}
