import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Identification implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kName = "name";
  static const String kFatherLastName = "fatherlastname";
  static const String kMotherLastName = "motherlastname";
  static const String kBirthday = "birthday";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  String name = "";
  String fatherlastname = "";
  String motherlastname = "";
  DateTime? birthday;
  Status? statusNavigation;

  Identification(this.id, this.status, this.name, this.fatherlastname, this.motherlastname, this.birthday, this.statusNavigation);

  Identification.def();

  factory Identification.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    String name = json.get('name');
    String fatherlastname = json.get(kFatherLastName);
    String motherlastname = json.get(kMotherLastName);
    // DateTime birthday = json.get('birthday');

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    return Identification(id, status, name, fatherlastname, motherlastname, null, statusNavigation);
  }

  Identification clone({
    int? id,
    int? status,
    String? name,
    String? fatherlastname,
    String? motherlastname,
    DateTime? birthday,
    Status? statusNavigation,
  }) {
    return Identification(
      id ?? this.id,
      status ?? this.status,
      name ?? this.name,
      fatherlastname ?? this.fatherlastname,
      motherlastname ?? this.motherlastname,
      birthday ?? this.birthday,
      statusNavigation ?? this.statusNavigation,
    );
  }

  @override
  JObject encode() {
    // String? a = birthday?.toString().substring(0,10);
    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kName: name,
      kFatherLastName: fatherlastname,
      kMotherLastName: motherlastname,
      // kBirthday: a,
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (name.isEmpty || name.length > 32) results.add(CSMSetValidationResult(kName, "Name length must be between 1 and 32", "strictLength(1, 32)"));
    if (fatherlastname.isEmpty || fatherlastname.length > 32) results.add(CSMSetValidationResult(kFatherLastName, "FatherLastName length must be between 1 and 32", "strictLength(1, 32)"));
    if (motherlastname.isEmpty || motherlastname.length > 32) results.add(CSMSetValidationResult(kMotherLastName, "MotherLastName length must be between 1 and 32", "strictLength(1, 32)"));
    if (status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
}
