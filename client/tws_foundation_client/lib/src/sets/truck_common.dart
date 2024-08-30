import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TruckCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCarrier = "carrier";
  static const String kVin = "vin";
  static const String kEconomic = "economic";
  static const String kLocation = "location";
  static const String kSituation = "situation";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kSituationNavigation = 'SituationNavigation';

  @override
  int id = 0;
  int status = 1;
  int carrier = 0;
  String vin = "";
  String economic = "";
  int? location = 0;
  int? situation = 0;
  Situation? situationNavigation;
  Status? statusNavigation;
  

  TruckCommon(this.id, this.status, this.carrier, this.vin, this.economic, this.location, this.situation, this.situationNavigation, this.statusNavigation);
  factory TruckCommon.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int carrier = json.get('carrier');
    String vin = json.get('vin');
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
        
    return TruckCommon(id, status, carrier, vin, economic, location, situation, situationNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kCarrier: carrier,
      kVin: vin,
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
    if(vin.length != 17) results.add(CSMSetValidationResult(kVin, "VIN number must be 17 length", "strictLength(17)"));
    if(economic.isEmpty || economic.length > 16) results.add(CSMSetValidationResult(kEconomic, "Economic number length must be between 1 and 16", "strictLength(1,16)"));
    if(carrier < 0) results.add(CSMSetValidationResult(kCarrier, 'Carrier pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    
    // if(carrier  == 0 && carrierNavigation == null) results.add(CSMSetValidationResult("[$kCarrier, $kCarrierNavigation]", 'Required Carrier. Must be one Manufacturer insertion property', 'requiredInsertion()'));
    // if((carrier != 0 && carrierNavigation != null) && (carrierNavigation!.id != carrier)) results.add(CSMSetValidationResult("[$kCarrier, $kCarrierNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    // if(situation != null && situationNavigation != null){
    //   if(situation != 0 && (situationNavigation!.id != situation)) results.add(CSMSetValidationResult("[$kSituation, $kSituationNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    // }
    // if(situation != null && situation! < 0) results.add(CSMSetValidationResult(kSituation, 'Situation pointer must be equal or greater than 0', 'pointerHandler()'));
    // if(carrierNavigation != null) results = <CSMSetValidationResult>[...results, ...carrierNavigation!.evaluate()];
    // if(situationNavigation != null) results = <CSMSetValidationResult>[...results, ...situationNavigation!.evaluate()];
    return results;
  }
  TruckCommon.def();
  TruckCommon clone({
    int? id,
    int? status,
    int? carrier,
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

    return TruckCommon(id ?? this.id, status ?? this.status, carrier ?? this.carrier, vin ?? this.vin, economic ?? this.economic, location ?? this.location, situation ?? this.situation,
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
