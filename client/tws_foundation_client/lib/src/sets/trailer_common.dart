import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kType = "type";
  static const String kSituation = "situation";
  static const String kLocation = "location";
  static const String kEconomic = "economic";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = 'StatusNavigation';
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
    int id = json.get('id');
    int status = json.get('status');
    int? type = json.getDefault('type', null);
    int? situation = json.getDefault('situation', null);
    int? location = json.getDefault('location', null);
    String economic = json.get('economic');
    DateTime timestamp = json.get('timestamp');

    TrailerType? trailerTypeNavigation;
    if (json['TrailerTypeNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TrailerTypeNavigation', <String, dynamic>{});
      trailerTypeNavigation = deserealize<TrailerType>(rawNavigation, decode: TrailerTypeDecoder());
    }
    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    Location? locationNavigation;
    if (json['LocationNavigation'] != null) {
      JObject rawNavigation = json.getDefault('LocationNavigation', <String, dynamic>{});
      locationNavigation = deserealize<Location>(rawNavigation, decode: LocationDecoder());
    }
        
    return TrailerCommon(id, status, type, situation, location, economic, locationNavigation, trailerTypeNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
     // Avoiding EF tracking issues.
    JObject? locationNav = locationNavigation?.encode();
    if(location != null && location != 0) locationNav = null;
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kType: type,
      kSituation: situation,
      kLocation: location,
      kEconomic: economic,
      kTimestamp: timestamp.toIso8601String(),
      kLocationNavigation: locationNav,
      kTrailerTypeNavigation: trailerTypeNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode()
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(economic.length < 8 || economic.length > 12) results.add(CSMSetValidationResult(kEconomic, "Economic number length must be between 1 and 16", "strictLength(1,16)"));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(type != null){
      if(type! < 0) results.add(CSMSetValidationResult(kType, 'Trailer Type pointer must be empty, equal or greater than 0', 'pointerHandler()'));
    }
    return results;
  }
  TrailerCommon.def();
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
    return TrailerCommon(id ?? this.id, status ?? this.status, tType, situation ?? this.situation, location ?? this.location,
    economic ?? this.economic, locationNav ,typeNav, statusNavigation ?? this.statusNavigation);
  }
}

final class TrailerCommonDecoder implements CSMDecodeInterface<TrailerCommon> {
  const TrailerCommonDecoder();

  @override
  TrailerCommon decode(JObject json) {
    return TrailerCommon.des(json);
  }
}
