import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Address implements CSMSetInterface {
   /// [country] property key.
  static const String kCountry = "country";

  /// [state] property key.
  static const String kState = "state";

  /// [street] property key.
  static const String kStreet = "street";

  /// [altStreet] property key.
  static const String kAltStreet = "altstreet";

  /// [city] property key.
  static const String kCity = "city";

  /// [zip] property key.
  static const String kZip = "zip";

  /// [colonia] proeprty key.
  static const String kColonia = "colonia";

  /// [carriers] property key.
  static const String kCarriers = "Carriers";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

   /// Record database pointer.
  @override
  int id = 0;

  /// Country universal code identificator.
  String country = "";

  /// State name inside city address.
  String? state = "";

  /// Street name identification.
  String? street = "";

  /// Alternative street name identification.
  String? altStreet = "";

  /// City name inside country address.
  String? city = "";

  /// Internal postal code.
  String? zip = "";

  /// Internal demographical identification.
  String? colonia = "";

  /// List of carriers at this [Address]
  List<Carrier> carriers = <Carrier>[];

  /// Creates an [Address] object with required properties
  Address(this.id, this.country, this.state, this.street, this.altStreet, this.city, this.zip, this.colonia, this.carriers, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates an [Address] based on a [json] object.
  factory Address.des(JObject json) {
    List<Carrier> carriers = <Carrier>[];
    int id = json.get(SCK.kId);
    String country = json.get(kCountry);
    String? state = json.getDefault(kState, null);
    DateTime timestamp = json.get(SCK.kTimestamp);
    String? street = json.getDefault(kStreet, null);
    String? altStreet = json.getDefault(kAltStreet, null);
    String? city = json.getDefault(kCity, null);
    String? zip = json.getDefault(kZip, null);
    String? colonia = json.getDefault(kColonia, null);

    List<JObject> rawCarriersArray = json.getList(kCarriers);
    carriers = rawCarriersArray.map<Carrier>(Carrier.des).toList();
    
    return Address(id, country, state, street, altStreet, city, zip, colonia, carriers, timestamp: timestamp);
  }

  /// Creates an [Address] overriding the given properties.
  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kCountry: country,
      kState: state,
      kStreet: street,
      kAltStreet: altStreet,
      kCity: city,
      kZip: zip,
      kColonia: colonia,
      SCK.kTimestamp: timestamp.toIso8601String(),
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
    return Address(
      id ?? this.id, 
      country ?? this.country, 
      state ?? this.state, 
      street ?? this.street, 
      altStreet ?? this.altStreet, 
      city ?? this.city, 
      zip ?? this.zip, 
      colonia ?? this.colonia, 
      carriers ?? this.carriers
    );
  }
  
}