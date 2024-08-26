import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Situation implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kName = "name";
  static const String kDescription = "description";

  @override
  int id = 0;
  int status = 0;
  String name = "";
  String? description;
  Status? statusNavigation;
  List<Truck> trucks = <Truck>[];

  Situation(this.id, this.name, this.description);
  factory Situation.des(JObject json) {
    int id = json.get('id');
    String name = json.get('name');
    String? description = json.getDefault('description', null);
    
    return Situation(id, name, description);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kName: name,
      kDescription: description,
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.isEmpty || name.length > 25) results.add(CSMSetValidationResult(kName, "Name must be 25 max lenght and non-empty", "strictLength(1,25)"));
    return results;
  }

  Situation clone({
    int? id,
    int? status,
    String? name,
    String? description,
  }){
    String? desc = description ?? this.description;
    if(desc == "") desc = null;
    return Situation(id ?? this.id, name ?? this.name, desc);
  }

}

final class SituationDecoder implements CSMDecodeInterface<Situation> {
  const SituationDecoder();

  @override
  Situation decode(JObject json) {
    return Situation.des(json);
  }
}
