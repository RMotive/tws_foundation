import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerType implements CSMSetInterface {
  static const String kSize = "size";
  static const String kTrailerClass = "trailerClass";
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
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int trailerClass = json.get(kTrailerClass);
    String size = json.get(kSize);
    DateTime timestamp = json.get(SCK.kTimestamp);
    Status? statusNavigation;
    TrailerClass? trailerClassNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    if (json[kTrailerClassNavigation] != null) {
      JObject rawNavigation = json.getDefault(kTrailerClassNavigation, <String, dynamic>{});
      trailerClassNavigation = TrailerClass.des(rawNavigation);
    }
    
    return TrailerType(id, status, trailerClass, size, statusNavigation, trailerClassNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kTrailerClass: trailerClass,
      kSize: size,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kTrailerClassNavigation: trailerClassNavigation?.encode(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
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
    return TrailerType(
      id ?? this.id, 
      status ?? this.status, 
      trailerClass ?? this.trailerClass, 
      size ?? this.size, 
      statusNavigation ?? this.statusNavigation,  
      trailerClassNavigation ?? this.trailerClassNavigation
    );
  }
}
