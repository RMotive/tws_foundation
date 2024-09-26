import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Location implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kAddress = "address";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  int address = 0;
  String name = "";
  Status? statusNavigation;

  Location(this.id, this.status, this.address, this.name, this.statusNavigation);

  Location.a();

  factory Location.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    int address = json.get(kAddress);
    String name = json.get(SCK.kName);

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    return Location(id, status, address, name, statusNavigation);
  }

  Location clone({
    int? id,
    int? status,
    int? address,
    String? name,
    Status? statusNavigation,
  }) {
    return Location(
      id ?? this.id,
      status ?? this.status,
      address ?? this.address,
      name ?? this.name,
      statusNavigation ?? this.statusNavigation,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kName: name,
      kStatus: status,
      kAddress: address,
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (name.isEmpty || name.length > 30) results.add(CSMSetValidationResult(SCK.kName, "Name must be 25 max lenght and non-empty", "strictLength(1,30)"));
    if (address < 0) results.add(CSMSetValidationResult(kAddress, 'Address pointer must be equal or greater than 0', 'pointerHandler()'));
    if (status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
}
