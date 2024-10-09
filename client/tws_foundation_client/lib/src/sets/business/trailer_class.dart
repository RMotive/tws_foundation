import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerClass implements CSMSetInterface {

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
    int id = json.get(SCK.kId);
    String name = json.get(SCK.kName);
    DateTime timestamp = json.get(SCK.kTimestamp);
    String? description = json.getDefault(SCK.kDescription, null);
    
    return TrailerClass(id, name, description, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kName: name,
      SCK.kDescription: description,
      SCK.kTimestamp: timestamp.toIso8601String(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.isEmpty || name.length > 30) results.add(CSMSetValidationResult(SCK.kName, "Name must be 25 max lenght and non-empty", "strictLength(1,30)"));
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
    
    return TrailerClass(
      id ?? this.id, 
      name ?? this.name, 
      desc
    );
  }

}

