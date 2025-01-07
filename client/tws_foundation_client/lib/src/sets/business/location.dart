import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Location] Class stores the relevant values to locate a place or item.
final class Location implements CSMSetInterface {

  /// [address] Property key.
  static const String kAddress = "address";

  /// [waypoint] Property key.
  static const String kWaypoint = "waypoint";

  /// [waypointNavigation] Property key.
  static const String kWaypointNavigation = "WaypointNavigation";
  
  /// [addressNavigation] Property key.
  static const String kAddressNavigation = "AddressNavigation";


  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 
  
  /// Record database pointer.
  @override
  int id = 0;
  /// Foreign relation [Status] Pointer.
  int status = 1;

  /// Foreign relation [Address] Pointer.
  int? address;

  /// Foreign relation [Waypoint] Pointer.
  int? waypoint;
  
  /// Location name value.
  String name = "";
  
  /// [Address] navigation set.
  Address? addressNavigation;

  /// [Waypoint] navigation set.
  Waypoint? waypointNavigation;

  /// [Status] navigation set.
  Status? statusNavigation;

  /// Creates an [Location] object with default values.
  Location.a(){
    _timestamp = DateTime.now();
  }

  /// Creates an [Location] object with required parameters.
  Location(
    this.id,
    this.status,
    this.address,
    this.waypoint,
    this.name,
    this.addressNavigation,
    this.waypointNavigation,
    this.statusNavigation, {
    DateTime? timestamp,
  }) {
    _timestamp = timestamp ?? DateTime.now();
  }

  factory Location.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int? address = json.getDefault(kAddress, null);
    int? waypoint = json.getDefault(kWaypoint, null);

    String name = json.get(SCK.kName);    
    DateTime timestamp = json.get(SCK.kTimestamp);

    Address? addressNavigation;
    if (json[kAddressNavigation] != null) {
      JObject rawNavigation = json.getDefault(kAddressNavigation, <String, dynamic>{});
      addressNavigation = Address.des(rawNavigation);
    }

    Waypoint? waypointNavigation;
    if (json[kWaypointNavigation] != null) {
      JObject rawNavigation = json.getDefault(kWaypointNavigation, <String, dynamic>{});
      waypointNavigation = Waypoint.des(rawNavigation);
    }

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    return Location(id, status, address, waypoint ,name, addressNavigation, waypointNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kName: name,
      SCK.kStatus: status,
      kAddress: address,
      kWaypoint: waypoint,
      kAddressNavigation: addressNavigation?.encode(),
      kWaypointNavigation: waypointNavigation?.encode(),
      SCK.kTimestamp: timestamp.toIso8601String(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.isEmpty || name.length > 30) results.add(CSMSetValidationResult(SCK.kName, "${SCK.kName} must be 25 max lenght and non-empty", "strictLength(1,30)"));
    if(address != null && address! < 0) results.add(CSMSetValidationResult(kAddress, '$kAddress pointer must be equal or greater than 0', 'pointerHandler()'));
    if(waypoint != null && waypoint! < 0) results.add(CSMSetValidationResult(kWaypoint, '$kWaypoint pointer must be equal or greater than 0', 'pointerHandler()'));

    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, '${SCK.kStatus} pointer must be equal or greater than 0', 'pointerHandler()'));
    if(addressNavigation != null) results = <CSMSetValidationResult>[...results, ...addressNavigation!.evaluate()];
    if(waypointNavigation != null) results = <CSMSetValidationResult>[...results, ...waypointNavigation!.evaluate()];
    return results;
  }
  
  /// Creates a clone for a [Driver] object, overriding the given values.
  Location clone({
    int? id,
    int? status,
    int? address,
    int? waypoint,
    Address? addressNavigation,
    Waypoint? waypointNavigation,
    String? name,
    Status? statusNavigation,
  }){
    
    if(address == 0){
      this.address = null;
      this.addressNavigation = null;
      address = null;
      addressNavigation = null;
    }

    if(waypoint == 0){
      this.waypoint = null;
      this.waypointNavigation = null;
      waypoint = null;
      waypointNavigation = null;
    }

    return Location(
      id ?? this.id,
      status ?? this.status,
      address ?? this.address,
      waypoint ?? this.waypoint,
      name ?? this.name,
      addressNavigation ?? this.addressNavigation,
      waypointNavigation ?? this.waypointNavigation,
      statusNavigation ?? this.statusNavigation,
    );
  }

}