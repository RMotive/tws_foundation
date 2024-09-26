import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class LoadType implements CSMSetInterface {
  static const String kName = "name";
  static const String kDescription = "description";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = 'StatusNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  String name = "";
  String? description;

  LoadType(this.id, this.name, this.description, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory LoadType.des(JObject json) {
    int id = json.get('id');
    String name = json.get('name');
    DateTime timestamp = json.get('timestamp');
    String? description = json.getDefault('description', null);
    
    return LoadType(id, name, description, timestamp: timestamp);
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
    if(name.isEmpty || name.length > 25) results.add(CSMSetValidationResult(kName, "Name must be 25 max lenght and non-empty", "strictLength(1,25)"));
    return results;
  }
  LoadType.def();
  LoadType clone({
    int? id,
    int? status,
    String? name,
    String? description,
    Status? statusNavigation,
    List<Truck>? trucks
  }){
    String? desc = description ?? this.description;
    if(desc == "") desc = null;
    return LoadType(id ?? this.id, name ?? this.name, desc);
  }

}

final class LoadTypeDecoder implements CSMDecodeInterface<LoadType> {
  const LoadTypeDecoder();

  @override
  LoadType decode(JObject json) {
    return LoadType.des(json);
  }
}
