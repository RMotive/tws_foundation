import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TruckCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCarrier = "carrier";
  static const String kEconomic = "economic";
  static const String kLocation = "location";
  static const String kSituation = "situation";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kSituationNavigation = 'SituationNavigation';

  @override
  int id = 0;
  int status = 1;
  String economic = "";
  int? location = 0;
  int? situation = 0;
  Situation? situationNavigation;
  Status? statusNavigation;
  

  TruckCommon(this.id, this.status, this.economic, this.location, this.situation, this.situationNavigation, this.statusNavigation);
  factory TruckCommon.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    String economic = json.get('economic');
    int? location = json.getDefault('location', null);
    int? situation = json.getDefault('situation', null);
    
    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    Situation? situationNavigation;
    if (json['SituationNavigation'] != null) {
      JObject rawNavigation = json.getDefault('SituationNavigation', <String, dynamic>{});
      situationNavigation = deserealize<Situation>(rawNavigation, decode: SituationDecoder());
    }
        
    return TruckCommon(id, status, economic, location, situation, situationNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kEconomic: economic,
      kLocation: location,
      kSituation: situation,
      kSituationNavigation: situationNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode()
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(economic.isEmpty || economic.length > 16) results.add(CSMSetValidationResult(kEconomic, "Economic number length must be between 1 and 16", "strictLength(1,16)"));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  TruckCommon.def();
  TruckCommon clone({
    int? id,
    int? status,
    String? vin,
    String? economic,
    int? location,
    int? situation,
    Situation? situationNavigation,
    Status? statusNavigation,
  }){
    int? situationIndex = situation ?? this.situation;
    Situation? situationNav = situationNavigation ?? this.situationNavigation;
    if(situationIndex == 0){
      situationIndex = null;
      situationNav = null; 
    }

    
    return TruckCommon(id ?? this.id, status ?? this.status, economic ?? this.economic, location ?? this.location, situation ?? this.situation,
    situationNav ,statusNavigation ?? this.statusNavigation);
  }
}

final class TruckCommonDecoder implements CSMDecodeInterface<TruckCommon> {
  const TruckCommonDecoder();

  @override
  TruckCommon decode(JObject json) {
    return TruckCommon.des(json);
  }
}
