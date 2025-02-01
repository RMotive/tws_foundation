
import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Action implements CSMSetInterface {
  
  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// [enable] property key.
  static const String kEnable = 'enable';

  /// Creates an [Action] object with default values.
  Action.a();

  /// Database record pointer.
  @override
  int id = 0;

  /// Action name.
  String name = "";
  
  /// Action description.
  String? description;

  /// Boolean validation status.
  bool enable = false;

  /// Creates an [Action] object based on required fields.
  Action(this.id, this.name, this.description, this.enable, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates an [Action] object based on a serealized JSON.
  factory Action.des(JObject json) {
    int id = json.get(SCK.kId);
    DateTime timestamp = json.get(SCK.kTimestamp);
    String name = json.get(SCK.kName);
    String? description = json.getDefault(SCK.kDescription, null);
    bool enable = json.get(kEnable);
        
    return Action(id, name, description, enable, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kName: name,
      SCK.kDescription: description,
      kEnable: enable,
      SCK.kTimestamp: timestamp.toIso8601String(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.trim().isEmpty && name.trim().length > 25) results.add(CSMSetValidationResult(SCK.kName, '${SCK.kName} cannot be empty and higher than 25 character length.', 'strictLength(1,25)'));
    
    return results;
  }
  
  /// Creates an [Action] overriding the given properties.
  Action clone({
    int? id,
    String? name,
    String? description,
    bool? enable,
  }) {
    if(description == ""){
      this.description = null;
      description = null;
    }

    return Action(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      enable ?? this.enable,
    );
  }
}
