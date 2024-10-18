import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Plate implements CSMSetInterface {
  static const String kIdentifier = "identifier";
  static const String kState = "state";
  static const String kCountry = "country";
  static const String kExpiration = "expiration";
  static const String kTruck = "truck";
  static const String kTrailer = "trailer";
  static const String kTruckCommonNavigation = "TruckCommonNavigation";
  static const String kTrailerCommonNavigation = "TrailerCommonNavigation";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  String identifier = "";
  String? state;
  String country = "";
  DateTime? expiration;
  int? truck;
  int? trailer;
  Status? statusNavigation;
  TruckCommon? truckCommonNavigation;
  TrailerCommon? trailerCommonNavigation;

  Plate.a(){
    _timestamp = DateTime.now();
  }

  Plate(this.id, this.status, this.identifier, this.state, this.country, this.expiration, this.truck, this.trailer, this.statusNavigation, this.truckCommonNavigation, this.trailerCommonNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Plate.des(JObject json) {
    TruckCommon? truckCommonNavigation;
    if (json[kTruckCommonNavigation] != null) {
      truckCommonNavigation = TruckCommon.des(json[kTruckCommonNavigation]);
    }

    TrailerCommon? trailerNavigation;
    if (json[kTrailerCommonNavigation] != null) {
      trailerNavigation = TrailerCommon.des(json[kTrailerCommonNavigation]);
    }

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
    int id = json.get('id');
    int status = json.get('status');
    String identifier = json.get('identifier');
    String? state = json.getDefault('state', null);
    String country = json.get('country');
    DateTime timestamp = json.get('timestamp');

    String? exp = json.getDefault("expiration", null);
    DateTime? expiration = exp != null? DateTime.parse(exp) : null;
    
    int? truck = json.getDefault('truck', null);
    int? trailer = json.getDefault('trailer', null);
    return Plate(id, status, identifier, state, country, expiration, truck, trailer, statusNavigation, truckCommonNavigation, trailerNavigation, timestamp: timestamp);
  }
  
  @override
  JObject encode() {
    String? exp = expiration?.toString().substring(0,10);
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kIdentifier: identifier,
      kState: state,
      kCountry: country,
      kExpiration: exp,
      kTruck: truck,
      kTrailer: trailer,
      SCK.kTimestamp: timestamp.toIso8601String(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
      kTruckCommonNavigation: truckCommonNavigation?.encode(),
      kTrailerCommonNavigation: trailerCommonNavigation?.encode()
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(identifier.length < 5 || identifier.length > 12) results.add(CSMSetValidationResult(kIdentifier, "Identifier length must be between 8 and 12", "strictLength(8,12)"));
    if(state != null){
      if(state!.length < 2 || state!.length > 4) results.add(CSMSetValidationResult(kState, "State length must be between 2 and 4", "strictLength(2,4)"));
    }
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
    TrailerCommon? trailerCommonNavigation,
  }) {
    if(state != null){
      if(state.trim().isEmpty){
        this.state = null;
        status = null;
      }
    }
    if(truck == 0){
      this.truck = null;
      this.truckCommonNavigation = null;
      truck = null;
      truckCommonNavigation = null;
    }
    if(trailer == 0){
      this.trailer = null;
      this.trailerCommonNavigation = null;
      trailer = null;
      trailerCommonNavigation = null;
    }
    if(expiration != null){
      if(expiration == DateTime(0)){
        this.expiration = null;
        expiration = null;
      }
    }
    return Plate(
      id ?? this.id,
      status ?? this.status,
      identifier ?? this.identifier,
      state ?? this.state,
      country ?? this.country,
      expiration ?? this.expiration,
      truck ?? this.truck,
      trailer ?? this.trailer,
      statusNavigation ?? this.statusNavigation,
      truckCommonNavigation ?? this.truckCommonNavigation,
      trailerCommonNavigation ?? this.trailerCommonNavigation,
    );
  }
}
