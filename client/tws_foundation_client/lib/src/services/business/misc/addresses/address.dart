
import 'package:csm_client/csm_client.dart';

/// [Address] default builder.
Address addressBuilder() => Address();

/// Defines a business entity that stores information about a location [Address] for buildings, employees, etc.
final class Address extends EntityB<Address> {
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
  static const String kSubdivision = "subdivision";

  /// [carriers] property key.
  static const String kCarriers = "Carriers";

  /// Country universal code identificator.
  String country = "";

  /// State name inside city address.
  String? state;

  /// Street name identification.
  String? street;

  /// Alternative street name identification.
  String? altStreet;

  /// City name inside country address.
  String? city;

  /// Internal postal code.
  String? zip;

  /// Internal demographical identification.
  String? subdivision;

  /// Generates a new [Address] instance from mandatory values.
  Address();

  /// Creates a new [Address] with specific values.
  Address.a(this.country, this.state, this.street, this.altStreet, this.city, this.zip, this.subdivision);     
  
  /// Validate nulleable inputs to avoid [Address] entities with empty values.
  Address? sanitize({
    String? country,
    String? state,
    String? street,
    String? altStreet,
    String? city,
    String? zip,
    String? subdivision,
  }){

    if(country != null) this.country = country;

    if(state != null && state.trim().isEmpty){
      this.state = null;
      state = null;
    }

    if(street != null && street.trim().isEmpty){
      this.street = null;
      street = null;
    }

    if(altStreet != null && altStreet.trim().isEmpty){
      this.altStreet = null;
      altStreet = null;
    }

    if(city != null && city.trim().isEmpty){
      this.city = null;
      city = null;
    }

    if(zip != null && zip.trim().isEmpty){
      this.zip = null;
      zip = null;
    }

    if(subdivision != null && subdivision.trim().isEmpty){
      this.subdivision = null;
      subdivision = null;
    }

    if(this.country.trim().isEmpty &&
      state == null &&
      street == null &&
      altStreet == null &&
      city == null &&
      zip == null &&
      subdivision == null) {
        return null;
      }

    return Address.a(
      country ?? this.country, 
      state ?? this.state, 
      street ?? this.street, 
      altStreet ?? this.altStreet, 
      city ?? this.city, 
      zip ?? this.zip, 
      subdivision ?? this.subdivision, 
    );
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kState: state,
          kStreet: street,
          kAltStreet: altStreet,
          kCity: city,
          kZip: zip,
          kCountry: country,
          kSubdivision: kSubdivision
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    state = encode.get(kState, null);
    street = encode.get(kStreet, null);
    altStreet = encode.get(kAltStreet, null);
    city = encode.get(kCity, null);
    zip = encode.get(kZip, null);
    country = encode.get(kCountry);
    subdivision = encode.get(kSubdivision, null);
  }

  @override
  List<EntityInvalidation<Address>> evaluate() {
    List<EntityInvalidation<Address>> results = <EntityInvalidation<Address>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Address>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (country.length < 2 || country.length > 3) results.add(EntityInvalidation<Address>(this, PropertyInfo(kCountry, String, country), "Country must be between 2 and 3 length", "strictLength(2,3)"));
    if (state != null){
      if (state!.length < 2 || state!.length > 4) results.add(EntityInvalidation<Address>(this, PropertyInfo(kState, String, state), "State length must be between 2 and 4", "strictLength(2,4)"));
    } 
    if (street != null && street!.trim().isEmpty || street!.length > 100) results.add(EntityInvalidation<Address>(this, PropertyInfo(kStreet, String, street), "Street must be 100 max length  or be empty",  "strictLength(0, 100)"));
    if (altStreet != null &&  altStreet!.trim().isEmpty || altStreet!.length > 100) results.add(EntityInvalidation<Address>(this,  PropertyInfo(kAltStreet, String, altStreet), "altStreet must be 100 max length or be empty",  "strictLength(0, 100)"));
    if (city != null && city!.trim().isEmpty || city!.length > 30) results.add(EntityInvalidation<Address>(this, PropertyInfo(kCity, String, city), "City must be 30 max length or be empty",  "strictLength(0, 30)"));
    if (zip != null &&  zip!.trim().isEmpty || zip!.length > 5) results.add(EntityInvalidation<Address>(this, PropertyInfo(kZip, String, zip), "ZIP must be 5 length  or be empty ",  "strictLength(5)"));
    if (subdivision != null && subdivision!.trim().isEmpty || subdivision!.length > 30) results.add(EntityInvalidation<Address>(this, PropertyInfo(kSubdivision, String, subdivision), "Subdivision/Colonia must be 30 max length or be empty",  "strictLength(0, 30)"));
    return results;
  }
}
