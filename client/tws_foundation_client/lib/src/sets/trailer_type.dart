import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerType implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kSize = "size";
  static const String kTrailerClass = "trailerClass";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTrailerClassNavigation = 'TrailerClassNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  int trailerClass = 0;
  String size = "";
  DateTime year = DateTime.now();
  Status? statusNavigation;
  TrailerClass? trailerClassNavigation;
  TrailerType(this.id, this.status, this.trailerClass, this.size, this.statusNavigation, this.trailerClassNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory TrailerType.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int trailerClass = json.get('trailerClass');
    String size = json.get('size');
    DateTime timestamp = json.get('timestamp');
    Status? statusNavigation;
    TrailerClass? trailerClassNavifation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    if (json['TrailerClassNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TrailerClassNavigation', <String, dynamic>{});
      trailerClassNavifation = deserealize<TrailerClass>(rawNavigation, decode: TrailerClassDecoder());
    }
    
    return TrailerType(id, status, trailerClass, size, statusNavigation, trailerClassNavifation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kTrailerClass: trailerClass,
      kSize: size,
      kTimestamp: timestamp.toIso8601String(),
      kTrailerClassNavigation: trailerClassNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(size.length > 16) results.add(CSMSetValidationResult(kSize, "Max name length is 16 characters", "strictLength(1, 16)"));
    
    return results;
  }
  TrailerType.def();
  TrailerType clone({
    int? id,
    int? status,
    int? trailerClass,
    String? size,
    Status? statusNavigation,
    TrailerClass? trailerClassNavigation
  }){
    return TrailerType(id ?? this.id, status ?? this.status, trailerClass ?? this.trailerClass, size ?? this.size, statusNavigation ?? this.statusNavigation,  trailerClassNavigation ?? this.trailerClassNavigation);
  }
}

final class TrailerTypeDecoder implements CSMDecodeInterface<TrailerType> {
  const TrailerTypeDecoder();

  @override
  TrailerType decode(JObject json) {
    return TrailerType.des(json);
  }
}
