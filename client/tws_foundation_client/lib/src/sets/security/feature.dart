import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Feature implements CSMSetInterface {

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Database record pointer.
  @override
  int id;
  /// Feature name.
  String name;
  /// Feature description
  String? description;

  Feature(
    this.id,
    this.name,
    this.description, {
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  /// Creates an [Feature] object based on a serealized JSON.
  factory Feature.des(JObject json) {
    int id = json.get(SCK.kId);
    String name = json.get(SCK.kName);
    String? description = json.getDefault(SCK.kDescription, null);
    DateTime timestamp = json.get(SCK.kTimestamp);
        
    return Feature(id, name, description, timestamp: timestamp);
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
    if(name.trim().isEmpty && name.trim().length > 25) results.add(CSMSetValidationResult(SCK.kName, '${SCK.kName} cannot be empty and higher than 25 character length.', 'strictLength(1,25)'));

    return results;
  }

  /// Creates an [Feature] overriding the given properties.
  Feature clone({
    int? id,
    String? name,
    String? description,
  }){
    if(description == ""){
      this.description = null;
      description = null;
    }
    return Feature(
      id ?? this.id, 
      name ?? this.name, 
      description ?? this.description,
    );
  }
}
