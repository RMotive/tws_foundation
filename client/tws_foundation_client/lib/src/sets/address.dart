import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Address implements CSMSetInterface {
  static const String kCountry = "country";
  static const String kState = "state";
  static const String kStreet = "street";
  static const String kAltStreet = "altstreet";
  static const String kCity = "city";
  static const String kZip = "zip";
  static const String kColonia = "colonia";
  static const String kCarriers = "Carriers";
  static const String kTimestamp = "timestamp";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  String country = "";
  String? state = "";
  String? street = "";
  String? altStreet = "";
  String? city = "";
  String? zip = "";
  String? colonia = "";
  List<Carrier> carriers = <Carrier>[];

  Address(this.id, this.country, this.state, this.street, this.altStreet, this.city, this.zip, this.colonia, this.carriers, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }
  
  factory Address.des(JObject json) {
    List<Carrier> carriers = <Carrier>[];
    int id = json.get('id');
    String country = json.get('country');
    String? state = json.getDefault('state', null);
    DateTime timestamp = json.get('timestamp');
    String? street = json.getDefault('street', null);
    String? altStreet = json.getDefault('altStreet', null);
    String? city = json.getDefault('city', null);
    String? zip = json.getDefault('zip', null);
    String? colonia = json.getDefault('colonia', null);

    List<JObject> rawCarriersArray = json.getList('Carriers');
    carriers = rawCarriersArray.map<Carrier>((JObject e) => deserealize(e, decode: CarrierDecoder())).toList();
    
    return Address(id, country, state, street, altStreet, city, zip, colonia, carriers, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kCountry: country,
      kState: state,
      kStreet: street,
      kAltStreet: altStreet,
      kCity: city,
      kZip: zip,
      kColonia: colonia,
      kTimestamp: timestamp.toIso8601String(),
      kCarriers: carriers.map((Carrier i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(country.length > 3) results.add(CSMSetValidationResult(kCountry, "Country must be 3 length", "strictLength(3)"));
    if(country.length < 2 && country.length > 3) results.add(CSMSetValidationResult(kCountry,"Country must be between 2 and 3 length", "strictLength(2,3)"));
    if(state != null){
      if(state!.length < 2 || state!.length > 4) results.add(CSMSetValidationResult(kState, "State length must be between 2 and 4", "strictLength(2,4)"));
    } 
    if(street != null && street!.length > 100) results.add(CSMSetValidationResult(kStreet, "Street must be 100 max length ",  "strictLength(0, 100)"));
    if(altStreet != null && altStreet!.length > 100) results.add(CSMSetValidationResult(kAltStreet, "altStreet must be 100 max length ",  "strictLength(0, 100)"));
    if(city != null && city!.length > 30) results.add(CSMSetValidationResult(kCity, "City must be 30 max length ",  "strictLength(0, 30)"));
    if(zip != null && zip!.length > 5) results.add(CSMSetValidationResult(kZip, "ZIP must be 5 length ",  "strictLength(5)"));
    if(colonia != null && colonia!.length > 30) results.add(CSMSetValidationResult(kColonia, "Colonia must be 30 max length ",  "strictLength(0, 30)"));

    return results;
  }
  Address.def();

  Address clone({
    int? id,
    String? country,
    String? state,
    String? street,
    String? altStreet,
    String? city,
    String? zip,
    String? colonia,
    List<Carrier>? carriers
  }){
    return Address(id ?? this.id, country ?? this.country, state ?? this.state, street ?? this.street, altStreet ?? this.altStreet, city ?? this.city, zip ?? this.zip, colonia ?? this.colonia, carriers ?? this.carriers);
  }
  
}

final class AddressDecoder implements CSMDecodeInterface<Address> {
  const AddressDecoder();

  @override
  Address decode(JObject json) {
    return Address.des(json);
  }
}
