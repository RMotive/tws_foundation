import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerCommon implements CSMSetInterface {
  static const String kType = "type";
  static const String kSituation = "situation";
  static const String kLocation = "location";
  static const String kEconomic = "economic";
  static const String kTrailerTypeNavigation = 'TrailerTypeNavigation';
  static const String kLocationNavigation = "LocationNavigation";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  @override
  int id = 0;
  int status = 1;
  int? type;
  int? situation;
  int? location;
  String economic = "";
  Location? locationNavigation;
  TrailerType? trailerTypeNavigation;
  Status? statusNavigation;
  
  TrailerCommon(this.id, this.status, this.type, this.situation, this.location, this.economic,  this.locationNavigation, this.trailerTypeNavigation, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory TrailerCommon.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int? type = json.getDefault(kType, null);
    int? situation = json.getDefault(kSituation, null);
    int? location = json.getDefault(kLocation, null);
    String economic = json.get(kEconomic);
    DateTime timestamp = json.get(SCK.kTimestamp);

    TrailerType? trailerTypeNavigation;
    if (json[kTrailerTypeNavigation] != null) {
      JObject rawNavigation = json.getDefault(kTrailerTypeNavigation, <String, dynamic>{});
      trailerTypeNavigation = TrailerType.des(rawNavigation);
    }
    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    Location? locationNavigation;
    if (json[kLocationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kLocationNavigation, <String, dynamic>{});
      locationNavigation = Location.des(rawNavigation);
    }
        
    return TrailerCommon(id, status, type, situation, location, economic, locationNavigation, trailerTypeNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
     // Avoiding EF tracking issues.
    JObject? locationNav = locationNavigation?.encode();
    if(location != null && location != 0) locationNav = null;
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kType: type,
      kSituation: situation,
      kLocation: location,
      kEconomic: economic,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kLocationNavigation: locationNav,
      kTrailerTypeNavigation: trailerTypeNavigation?.encode(),
      SCK.kStatusNavigation: statusNavigation?.encode()
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(economic.trim().isEmpty || economic.length > 16) results.add(CSMSetValidationResult(kEconomic, "Economic number length must be between 1 and 16", "strictLength(1,16)"));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(type != null){
      if(type! < 0) results.add(CSMSetValidationResult(kType, 'Trailer Type pointer must be empty, equal or greater than 0', 'pointerHandler()'));
    }
    return results;
  }
  TrailerCommon clone({
    int? id,
    int? status,
    int? type,
    int? situation,
    int? location,
    String? economic,
    Location? locationNavigation,
    TrailerType? trailerTypeNavigation,
    Status? statusNavigation,
  }){
    Location? locationNav = locationNavigation ?? this.locationNavigation;
    if(type == 0) locationNav = null;

    int? tType = type ?? this.type;
    TrailerType? typeNav = trailerTypeNavigation ?? this.trailerTypeNavigation;
    if(type == 0){
      tType = null;
      typeNav = null;
    }
    return TrailerCommon(
      id ?? this.id, 
      status ?? this.status, 
      tType, 
      situation ?? this.situation, 
      location ?? this.location,
      economic ?? this.economic, 
      locationNav,
      typeNav, 
      statusNavigation ?? this.statusNavigation,
    );
  }
}

