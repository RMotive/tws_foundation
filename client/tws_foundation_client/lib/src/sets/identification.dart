import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Identification implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kName = "name";
  static const String kFatherLastName = "fatherlastname";
  static const String kMotherLastName = "motherlastname";
  static const String kBirthday = "birthday";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = 'StatusNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 


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
    int id = json.get('id');
    int status = json.get('status');
    String name = json.get('name');
    String fatherlastname = json.get('fatherlastname');
    String motherlastname = json.get('motherlastname');
    DateTime timestamp = json.get('timestamp');

    String? birth = json.getDefault('birthday', null);
    DateTime? birthday = birth != null? DateTime.parse(birth) : null;

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
        
    return Identification(id, status, name, fatherlastname, motherlastname, birthday, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    String? a = birthday?.toString().substring(0,10);
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kName: name,
      kFatherLastName: fatherlastname,
      kMotherLastName: motherlastname,
      kTimestamp: timestamp.toIso8601String(),
      kBirthday: a,
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.trim().isEmpty || name.length > 32) results.add(CSMSetValidationResult(kName, "El nombre no debe de estar vacio y no debe tener mas de 32 caracteres", "strictLength(1, 32)"));
    if(fatherlastname.trim().isEmpty || fatherlastname.length > 32) results.add(CSMSetValidationResult(kFatherLastName, "El apellido paterno no debe estar vacio y no debe tener mas de 32 caracteres", "strictLength(1, 32)"));
    if(motherlastname.trim().isEmpty || motherlastname.length > 32) results.add(CSMSetValidationResult(kMotherLastName, "El apellido materno no debe estar vacio y no debe tener mas de 32 caracteres", "strictLength(1, 32)"));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  Identification.def();
  Identification clone({
    int? id,
    int? status,
    String? name,
    String? fatherlastname,
    String? motherlastname,
    DateTime? birthday,
    Status? statusNavigation,
  }){
    return Identification(id ?? this.id, status ?? this.status, name ?? this.name, fatherlastname ?? this.fatherlastname, motherlastname ?? this.motherlastname, birthday ?? this.birthday, statusNavigation ?? this.statusNavigation);
  }
}

final class IdentificationDecoder implements CSMDecodeInterface<Identification> {
  const IdentificationDecoder();

  @override
  Identification decode(JObject json) {
    return Identification.des(json);
  }
}
