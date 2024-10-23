import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Section implements CSMSetInterface {
  static const String kYard = "yard";
  static const String kCapacity = "capacity";
  static const String kOcupancy = "ocupancy";
  static const String kLocationNavigation = "LocationNavigation";
  
  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  @override
  int id = 0;
  int status = 1;
  int yard = 0;
  String name = "";
  int capacity = 0;
  int ocupancy = 0;
  Location? locationNavigation;
  Status? statusNavigation;

  Section(this.id, this.status, this.yard, this.name, this.capacity, this.ocupancy, this.locationNavigation, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }
  
  factory Section.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int yard = json.get(kYard);
    String name = json.get(SCK.kName);
    DateTime timestamp = json.get(SCK.kTimestamp);
    int capacity = json.get(kCapacity);
    int ocupancy = json.get(kOcupancy);

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    Location? locationNavigation;
    if (json[kLocationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kLocationNavigation, <String, dynamic>{});
      locationNavigation = Location.des(rawNavigation);
    }

    return Section(id, status, yard, name, capacity, ocupancy, locationNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    // Avoiding EF tracking issues.
    JObject? locationNav = locationNavigation?.encode();
    if(yard != 0) locationNav = null;
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kYard: yard,
      SCK.kName: name,
      kCapacity: capacity,
      kOcupancy: ocupancy,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kLocationNavigation: locationNav,
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.isEmpty || name.length > 30) results.add(CSMSetValidationResult(SCK.kName, "Name must be 25 max lenght and non-empty", "strictLength(1,30)"));
    if(yard < 0) results.add(CSMSetValidationResult(kYard, 'Yard pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  Section.def();
  Section clone({
    int? id,
    int? status,
    int? yard,
    String? name,
    int? capacity,
    int? ocupancy,
    Location? locationNavigation,
    Status? statusNavigation,
  }){
   
    return Section(
      id ?? this.id, 
      status ?? this.status,
      yard ?? this.yard, 
      name ?? this.name, 
      capacity ?? this.capacity, 
      ocupancy ?? this.ocupancy,
      locationNavigation ?? this.locationNavigation, 
      statusNavigation ?? this.statusNavigation
    );
  }

}