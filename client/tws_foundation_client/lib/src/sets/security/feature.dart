import 'package:csm_client/csm_client.dart';

final class Feature implements CSMEncodeInterface {
  static const String kTimestamp = "timestamp";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  final int id;
  final String name;
  final String? description;

  Feature(this.id, this.name, this.description, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      kTimestamp: timestamp.toIso8601String(),
    };
  }
}
