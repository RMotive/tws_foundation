
import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Profile implements CSMSetInterface {
  
  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Creates an [Profile] object with default values.
  Profile.a();

  /// Database record pointer.
  @override
  int id = 0;

  /// Profile name.
  String name = "";
  
  /// profile description.
  String? description;

  /// Creates an [Permit] object based on required fields.
  Profile(this.id, this.name, this.description, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates an [Profile] object based on a serealized JSON.
  factory Profile.des(JObject json) {
    int id = json.get(SCK.kId);
    String name = json.get(SCK.kName);
    String? description = json.getDefault(SCK.kDescription, null);
    DateTime timestamp = json.get(SCK.kTimestamp);
        
    return Profile(id, name, description, timestamp: timestamp);
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
  
  /// Creates an [Profile] overriding the given properties.
  Profile clone({
    int? id,
    String? name,
    String? description,
  }) {
    if(description == ""){
      this.description = null;
      description = null;
    }

    return Profile(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
    );
  }
}
