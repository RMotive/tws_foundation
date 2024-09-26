import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Plate implements CSMSetInterface {
  static const String kIdentifier = "identifier";
  static const String kStatus = "status";
  static const String kState = "state";
  static const String kCountry = "country";
  static const String kExpiration = "expiration";
  static const String kTruck = "truck";
  static const String kTrailer = "trailer";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = "StatusNavigation";
  static const String kTruckCommonNavigation = "TruckCommonNavigation";
  static const String kTrailerCommonNavigation = "TrailerCommonNavigation";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  String identifier = "";
  String state = "";
  String country = "";
  DateTime expiration = DateTime.now();
  int? truck;
  int? trailer;
  Status? statusNavigation;
  TruckCommon? truckCommonNavigation;
  TrailerCommon? trailerCommonNavigation;

  Plate.def();

  Plate(this.id, this.status, this.identifier, this.state, this.country, this.expiration, this.truck, this.trailer, this.statusNavigation, this.truckCommonNavigation, this.trailerCommonNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Plate.des(JObject json) {
    TruckCommon? truckCommonNavigation;
    if(json['TruckCommonNavigation'] != null){
      truckCommonNavigation =  deserealize<TruckCommon>(json['TruckCommonNavigation'], decode: TruckCommonDecoder());
    }

    TrailerCommon? trailerNavigation;
    if(json['TrailerCommonNavigation'] != null){
      trailerNavigation =  deserealize<TrailerCommon>(json['TrailerCommonNavigation'], decode: TrailerCommonDecoder());
    }

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
    int id = json.get('id');
    int status = json.get('status');
    String identifier = json.get('identifier');
    String state = json.get('state');
    String country = json.get('country');
    DateTime timestamp = json.get('timestamp');
    DateTime expiration = json.get("expiration");
    int? truck = json.getDefault('truck', null);
    int? trailer = json.getDefault('trailer', null);
    return Plate(id, status, identifier, state, country, expiration, truck, trailer, statusNavigation, truckCommonNavigation, trailerNavigation, timestamp: timestamp);
  }
  
  @override
  JObject encode() {
    String exp = expiration.toString().substring(0,10);
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kIdentifier: identifier,
      kState: state,
      kCountry: country,
      kExpiration: exp,
      kTruck: truck,
      kTrailer: trailer,
      kTimestamp: timestamp.toIso8601String(),
      kstatusNavigation: statusNavigation?.encode(),
      kTruckCommonNavigation: truckCommonNavigation?.encode(),
      kTrailerCommonNavigation: trailerCommonNavigation?.encode()
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(identifier.length < 8 || identifier.length > 12) results.add(CSMSetValidationResult(kIdentifier, "Identifier length must be between 8 and 12", "strictLength(8,12)"));
    if(state.length < 2 || state.length > 4) results.add(CSMSetValidationResult(kState, "State length must be between 2 and 4", "strictLength(2,4)"));
    if(country.length <2 || country.length > 3) results.add(CSMSetValidationResult(kCountry, "Country length must be between 2 and 3", "strictLength(2,3)"));

    return results;
  }


  Plate clone({
    int? id,
    int? status,
    String? identifier,
    String? state,
    String? country,
    DateTime? expiration,
    int? truck,
    int? trailer,
    Status? statusNavigation,
    TruckCommon? truckCommonNavigation,
    TrailerCommon? trailerCommonNavigation

  }){
    return Plate(id ?? this.id, status ?? this.status, identifier ?? this.identifier, state ?? this.state, country ?? this.country, expiration ?? this.expiration, truck ?? this.truck, trailer ?? this.trailer, statusNavigation ?? this.statusNavigation, truckCommonNavigation ?? this.truckCommonNavigation, trailerCommonNavigation ?? this.trailerCommonNavigation);
  }
  
}


final class PlateDecoder implements CSMDecodeInterface<Plate> {
  const PlateDecoder();

  @override
  Plate decode(JObject json) {
    return Plate.des(json);
  }
}
