import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerClass implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kName = "name";
  static const String kTimestamp = "timestamp";
  static const String kDescription = "description";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  String name = "";
  String? description;
  Status? statusNavigation;

  TrailerClass(this.id, this.name, this.description, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory TrailerClass.des(JObject json) {
    int id = json.get('id');
    String name = json.get('name');
    DateTime timestamp = json.get('timestamp');
    String? description = json.getDefault('description', null);
    
    return TrailerClass(id, name, description, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kName: name,
      kDescription: description,
      kTimestamp: timestamp.toIso8601String(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.isEmpty || name.length > 30) results.add(CSMSetValidationResult(kName, "Name must be 25 max lenght and non-empty", "strictLength(1,30)"));
    return results;
  }

  TrailerClass clone({
    int? id,
    int? status,
    String? name,
    String? description,
  }){
    String? desc = description ?? this.description;
    if(desc == "") desc = null;
    return TrailerClass(id ?? this.id, name ?? this.name, desc);
  }

}

final class TrailerClassDecoder implements CSMDecodeInterface<TrailerClass> {
  const TrailerClassDecoder();

  @override
  TrailerClass decode(JObject json) {
    return TrailerClass.des(json);
  }
}
