import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Waypoint] Class stores the exact geographic cordenates values for an specific place or item.
final class Waypoint implements CSMSetInterface {
  
  /// [longitude] Property key.
  static const String kLongitude = "longitude";

  /// [latitude] Property key.
  static const String kLatitude = "latitude";

  /// [altitude] Property key.
  static const String kAltitude = "altitude";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Creates an [Waypoint] object with default values.
  Waypoint.a();

  /// Database record pointer.
  @override
  int id = 0;

  /// Foreign relation [Status] pointer.
  int status = 1;

  /// Longitude cordenate value.
  double longitude = 0.0;
  
  /// Latitude cordenate value.
  double latitude = 0.0;

  /// Altitude cordenate value.
  double? altitude;

  /// [Status] Navigation set.
  Status? statusNavigation;
  
  /// Creates an [Identification] object based on required fields.
  Waypoint(this.id, this.status, this.longitude, this.latitude, this.altitude, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates an [Waypoint] object based on a serealized JSON.
  factory Waypoint.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    double longitude = json.getDefault(kLongitude, 0.0);
    double latitude = json.getDefault(kLatitude, 0.0);
    double? altitude = json.getDefault(kAltitude, null);

    DateTime timestamp = json.get(SCK.kTimestamp);

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
        
    return Waypoint(id, status, longitude, latitude, altitude, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kLongitude: longitude,
      kLatitude: latitude,
      kAltitude: altitude,
      SCK.kTimestamp: timestamp.toIso8601String(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(longitude == 0.0) results.add(CSMSetValidationResult(kLongitude, '$kLongitude invalid value.', 'invalidValue()'));
    if(latitude == 0.0) results.add(CSMSetValidationResult(kLatitude, '$latitude invalid value.', 'invalidValue()'));
    if(altitude != null && altitude == 0.0) results.add(CSMSetValidationResult(kAltitude, '$altitude invalid value.', 'invalidValue()'));

    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, '${SCK.kStatus} pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }

  /// Creates an [Waypoint] overwritting the given properties.
  Waypoint clone({
    int? id,
    int? status,
    double? longitude,
    double? latitude,
    double? altitude,
    Status? statusNavigation,
  }) {

    if(altitude == 0.0){
      this.altitude = null;
      altitude = null;
    }

    return Waypoint(
      id ?? this.id,
      status ?? this.status,
      longitude ?? this.longitude,
      latitude ?? this.latitude,
      altitude ?? this.altitude,
      statusNavigation ?? this.statusNavigation,
    );
  }
}
