import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerCommon implements CSMSetInterface {
  static const String kType = "type";
  static const String kSituation = "situation";
  static const String kLocation = "location";
  static const String kEconomic = "economic";
  static const String kTrailerTypeNavigation = 'TrailerTypeNavigation';
  static const String kLocationNavigation = "LocationNavigation";
  static const String kSituationNavigation = 'SituationNavigation';

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
  Situation? situationNavigation;
  Status? statusNavigation;
  
  TrailerCommon(
    this.id,
    this.status,
    this.type,
    this.situation,
    this.location,
    this.economic,
    this.locationNavigation,
    this.trailerTypeNavigation,
    this.situationNavigation,
    this.statusNavigation, {
    DateTime? timestamp,
  }) {
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

    Situation? situationNavigation;
    if (json[kSituationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kSituationNavigation, <String, dynamic>{});
      situationNavigation = Situation.des(rawNavigation);
    }
        
    return TrailerCommon(id, status, type, situation, location, economic, locationNavigation, trailerTypeNavigation, situationNavigation, statusNavigation, timestamp: timestamp);
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
      kSituationNavigation: situationNavigation?.encode(),
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
    if(situation != null){
      if(situation! < 0) results.add(CSMSetValidationResult(kSituation, 'Situation pointer must be empty, equal or greater than 0', 'pointerHandler()'));
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
    Situation? situationNavigation,
    Status? statusNavigation,
  }){
    if(situation == 0){
      this.situation = null;
      this.situationNavigation = null;
      situation = null;
      situationNavigation = null;
    }

    if(location == 0){
      this.location = null;
      this.locationNavigation = null;
      location = null;
      locationNavigation = null;
    }
   
    if(type == 0){
      this.type = null;
      this.trailerTypeNavigation = null;
      type = null;
      trailerTypeNavigation = null;
    }
    return TrailerCommon(
      id ?? this.id, 
      status ?? this.status, 
      type ?? this.type, 
      situation ?? this.situation, 
      location ?? this.location,
      economic ?? this.economic, 
      locationNavigation ?? this.locationNavigation,
      trailerTypeNavigation ?? this.trailerTypeNavigation, 
      situationNavigation ?? this.situationNavigation,
      statusNavigation ?? this.statusNavigation,
    );
  }
}

