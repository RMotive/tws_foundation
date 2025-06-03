
import 'package:csm_client/csm_client.dart';

final class Waypoint extends EntityB<Waypoint> {

  /// [longitude] property key.
  static const String kLongitude = "longitude";

  /// [latitude] property key.
  static const String klatitude = "latitude";

  /// [altitude] property key.
  static const String kAltitude = "altitude";

  /// Longitude coordenate value.
  double longitude = 0;

  /// Latitude coordinate value.
  double latitude = 0;

  /// Altitude coordinate value.
  double? altitude;

  /// Generates a new [Waypoint] instance from mandatory values.
  Waypoint();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kLongitude: longitude.toString(),
        klatitude: latitude.toString(),
        kAltitude: altitude?.toString(),
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
    List<EntityInvalidation<Waypoint>> results = <EntityInvalidation<Waypoint>>[];
    
    return results;
  }

}
