import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kTrailerClass = "class";
  static const String kSituation = "situation";
  static const String kLocation = "location";
  static const String kEconomic = "economic";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  int trailerClass = 0;
  int situation = 0;
  int? location;
  String economic = "";
  Status? statusNavigation;
  
  TrailerCommon(this.id, this.status, this.trailerClass, this.situation, this.location, this.economic, this.statusNavigation);
  factory TrailerCommon.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int trailerClass = json.get('class');
    int situation = json.get('situation');
    int? location = json.getDefault('location', null);
    String economic = json.get('economic');

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
        
    return TrailerCommon(id, status, trailerClass, situation, location, economic, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kTrailerClass: trailerClass,
      kSituation: situation,
      kLocation: location,
      kEconomic: economic,
      kstatusNavigation: statusNavigation?.encode()
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(economic.length < 8 || economic.length > 12) results.add(CSMSetValidationResult(kEconomic, "Economic number length must be between 1 and 16", "strictLength(1,16)"));
    if(trailerClass < 0) results.add(CSMSetValidationResult(kTrailerClass, 'Situation pointer must be equal or greater than 0', 'pointerHandler()'));
    if(situation < 0) results.add(CSMSetValidationResult(kSituation, 'Situation pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
  
    return results;
  }
  TrailerCommon.def();
  TrailerCommon clone({
    int? id,
    int? status,
    int? trailerClass,
    int? situation,
    int? location,
    String? economic,
    Status? statusNavigation,
  }){
    return TrailerCommon(id ?? this.id, status ?? this.status, trailerClass ?? this.trailerClass, situation ?? this.situation, location ?? this.location,
    economic ?? this.economic, statusNavigation ?? this.statusNavigation);
  }
}

final class TrailerCommonDecoder implements CSMDecodeInterface<TrailerCommon> {
  const TrailerCommonDecoder();

  @override
  TrailerCommon decode(JObject json) {
    return TrailerCommon.des(json);
  }
}
