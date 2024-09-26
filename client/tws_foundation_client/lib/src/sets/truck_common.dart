import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TruckCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kEconomic = "economic";
  static const String kLocation = "location";
  static const String kSituation = "situation";
  static const String kStatusNavigation = 'StatusNavigation';
  static const String kSituationNavigation = 'SituationNavigation';
  static const String kLocationNavigation = 'LocationNavigation';

  @override
  int id = 0;
  int status = 1;
  String economic = "";
  int? location = 0;
  int? situation = 0;
  Situation? situationNavigation;
  Location? locationNavigation;
  Status? statusNavigation;
  

  TruckCommon(this.id, this.status, this.economic, this.location, this.situation, this.situationNavigation, this.locationNavigation, this.statusNavigation);
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

    Location? locationNavigation;
    if (json['LocationNavigation'] != null) {
      JObject rawNavigation = json.getDefault('LocationNavigation', <String, dynamic>{});
      locationNavigation = deserealize<Location>(rawNavigation, decode: LocationDecoder());
    }
        
    return TruckCommon(id, status, economic, location, situation, situationNavigation, locationNavigation, statusNavigation);
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
      kLocationNavigation: locationNavigation?.encode(),
      kStatusNavigation: statusNavigation?.encode()
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(economic.isEmpty || economic.length > 16) results.add(CSMSetValidationResult(kEconomic, "Economic number length must be between 1 and 16", "strictLength(1,16)"));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(location != null){
      if(location! < 0) results.add(CSMSetValidationResult(kLocation, 'Location pointer must be equal or greater than 0', 'pointerHandler()'));
    }
    if(situation != null){
      if(situation! < 0) results.add(CSMSetValidationResult(kSituation, 'Situation pointer must be equal or greater than 0', 'pointerHandler()'));
    }

    if(locationNavigation != null) results = <CSMSetValidationResult>[...results, ...locationNavigation!.evaluate()];
    if(situationNavigation != null) results = <CSMSetValidationResult>[...results, ...situationNavigation!.evaluate()];


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
    Location? locationNavigation,
    Status? statusNavigation,
  }){
    
    int? situationIndex = situation ?? this.situation;
    Situation? situationNav = situationNavigation ?? this.situationNavigation;
    if(situationIndex == 0){
      situationIndex = null;
      situationNav = null; 
    }

    int? locationIndex = location ?? this.location;
    Location? locationNav = locationNavigation ?? this.locationNavigation;
    if(locationIndex == 0){
      locationIndex = null;
      locationNav = null; 
    }

    return TruckCommon(id ?? this.id, status ?? this.status, economic ?? this.economic, locationIndex, situationIndex,
    situationNav, locationNav ,statusNavigation ?? this.statusNavigation);
  }
}

final class TruckCommonDecoder implements CSMDecodeInterface<TruckCommon> {
  const TruckCommonDecoder();

  @override
  TruckCommon decode(JObject json) {
    return TruckCommon.des(json);
  }
}
