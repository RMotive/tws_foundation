
import 'dart:ffi';

import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/misc/locations/location.dart';

final class Waypoint extends EntityB<Waypoint> {

  /// [longitude] property key.
  static const String kLongitude = "longitude";

  /// [latitude] property key.
  static const String klatitude = "latitude";

  /// [altitude] property key.
  static const String kAltitude = "altitude";

  /// Max input value for coordinates.
  static const double _kMaxCoordinateValue = 999.999999;

  /// Longitude coordenate value.
  /// 
  /// Rules >
  /// value != 0 && value < +-999.999999
  double longitude = 0;

  /// Latitude coordinate value.
  /// 
  /// Rules >
  /// value != 0 && value < +-999.999999
  double latitude = 0;

  /// Altitude coordinate value.
  /// 
  /// Rules >
  /// value != 0 && value < +-999.999999
  double? altitude;

  /// Generates a new [Waypoint] instance from mandatory values.
  Waypoint();
  
  Waypoint? sanitize({
    double? longitude,
    double? latitude,
    double? altitude,
  }) {
    this.longitude = longitude ?? this.longitude;
    this.latitude = latitude ?? this.latitude;
    this.altitude = altitude ?? this.altitude;
    
    if(this.altitude != null && this.altitude == 0) this.altitude = null;

    if(longitude == 0 && latitude == 0 && (altitude == 0 || altitude == null)){
      return null;
    }
    return this;
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kLongitude: longitude.toString(),
        klatitude: latitude.toString(),
        kAltitude: altitude?.toString(),
        'location': Location().encode(),
      }
    );
  }
  
  @override
  // ignore: unnecessary_overrides
  void decode(DataMap encode) {
    super.decode(encode);
    longitude = encode.get(kLongitude);
    altitude = encode.get(kAltitude);
    latitude = encode.get(klatitude, null);
  }

  @override
  List<EntityInvalidation<Waypoint>> evaluate() {
    List<EntityInvalidation<Waypoint>> invalidations = <EntityInvalidation<Waypoint>>[];
    
    if(longitude == 0  || longitude > _kMaxCoordinateValue || longitude < -_kMaxCoordinateValue){
      invalidations.add(
        EntityInvalidation<Waypoint>(
          this,
          PropertyInfo(kLongitude, Double, longitude),
          'Must provide a valid longitude value',
          'value != 0',
        ),
      );
    }
    if(latitude == 0 || latitude > _kMaxCoordinateValue || latitude < -_kMaxCoordinateValue){
      invalidations.add(
        EntityInvalidation<Waypoint>(
          this,
          PropertyInfo(klatitude, Double, latitude),
          'Must provide a valid latitude value',
          'value != 0',
        ),
      );
    }

    if(altitude != null && (altitude == 0 || altitude! > _kMaxCoordinateValue || altitude! < -_kMaxCoordinateValue)){
      invalidations.add(
        EntityInvalidation<Waypoint>(
          this,
          PropertyInfo(kAltitude, Double, altitude),
          'Must provide a valid altitude value or be empty',
          'value != 0',
        ),
      );
    }
    
    return invalidations;
  }

}
