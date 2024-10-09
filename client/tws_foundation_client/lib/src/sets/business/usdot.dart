import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Government Mexico permit for logistic activities information, handling information related to a government permit and identification.
final class USDOT implements CSMSetInterface {
 
  /// [mc] property key.
  static const String kMc = "mc";

  /// [scac] property key.
  static const String kScac = "scac";
  
  /// Private timestamp property.
  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Creates an [USDOT] object with default properties.
  USDOT.a();

  @override
  int id = 0;
  int status = 1;
  String mc = "";
  String scac = "";
  Status? statusNavigation;

  USDOT(this.id, this.status, this.mc, this.scac, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory USDOT.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    String mc = json.get(kMc);
    String scac = json.get(kScac);
    DateTime timestamp = json.get(SCK.kTimestamp);
    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
        
    return USDOT(id, status, mc, scac, statusNavigation, timestamp: timestamp);
  }

  /// Creates an [USDOT] object overriding the given properties.
  USDOT clone({
    int? id,
    int? status,
    String? mc,
    String? scac,
    Status? statusNavigation,
  }){
    return USDOT(
      id ?? this.id, 
      status ?? this.status,
      mc ?? this.mc, 
      scac ?? this.scac, 
      statusNavigation ?? this.statusNavigation
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kMc: mc,
      kScac: scac,
      SCK.kTimestamp: timestamp.toIso8601String(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(mc.length != 7) results.add(CSMSetValidationResult(kMc, "MC number must be 7 length", "strictLength(7)"));
    if(scac.length != 4) results.add(CSMSetValidationResult(kScac, "SCAC number must be 4 length", "structLength(4)"));
    
    return results;
  }
  
}

