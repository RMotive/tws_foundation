import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Identification implements CSMSetInterface {
  static const String kFatherLastName = "fatherlastname";
  static const String kMotherLastName = "motherlastname";
  static const String kBirthday = "birthday";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  Identification.a();

  @override
  int id = 0;
  int status = 1;
  String name = "";
  String fatherlastname = "";
  String motherlastname = "";
  DateTime? birthday;
  Status? statusNavigation;

  Identification(this.id, this.status, this.name, this.fatherlastname, this.motherlastname, this.birthday, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Identification.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    String name = json.get(SCK.kName);
    String fatherlastname = json.get(kFatherLastName);
    String motherlastname = json.get(kMotherLastName);
    DateTime timestamp = json.get(SCK.kTimestamp);

    String? birth = json.getDefault(kBirthday, null);
    DateTime? birthday = birth != null? DateTime.parse(birth) : null;

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
        
    return Identification(id, status, name, fatherlastname, motherlastname, birthday, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    String? a = birthday?.toString().substring(0,10);
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      SCK.kName: name,
      kFatherLastName: fatherlastname,
      kMotherLastName: motherlastname,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kBirthday: a,
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.trim().isEmpty || name.length > 32) results.add(CSMSetValidationResult(SCK.kName, "El nombre no debe de estar vacio y no debe tener mas de 32 caracteres", "strictLength(1, 32)"));
    if(fatherlastname.trim().isEmpty || fatherlastname.length > 32) results.add(CSMSetValidationResult(kFatherLastName, "El apellido paterno no debe estar vacio y no debe tener mas de 32 caracteres", "strictLength(1, 32)"));
    if(motherlastname.trim().isEmpty || motherlastname.length > 32) results.add(CSMSetValidationResult(kMotherLastName, "El apellido materno no debe estar vacio y no debe tener mas de 32 caracteres", "strictLength(1, 32)"));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
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
}
