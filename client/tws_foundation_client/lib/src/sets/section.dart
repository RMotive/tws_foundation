import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Section implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kYard = "yard";
  static const String kName = "name";
  static const String kCapacity = "capacity";
  static const String kOcupancy = "ocupancy";
  static const String kTimestamp = "timestamp";
  static const String kLocationNavigation = "LocationNavigation";
  static const String kstatusNavigation = 'StatusNavigation';
  
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
    int id = json.get('id');
    int status = json.get('status');
    int yard = json.get('yard');
    String name = json.get('name');
    DateTime timestamp = json.get('timestamp');
    int capacity = json.get('capacity');
    int ocupancy = json.get('ocupancy');

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    Location? locationNavigation;
    if (json['LocationNavigation'] != null) {
      JObject rawNavigation = json.getDefault('LocationNavigation', <String, dynamic>{});
      locationNavigation = deserealize<Location>(rawNavigation, decode: LocationDecoder());
    }

    return Section(id, status, yard, name, capacity, ocupancy, locationNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    // Avoiding EF tracking issues.
    JObject? locationNav = locationNavigation?.encode();
    if(yard != 0) locationNav = null;
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kYard: yard,
      kName: name,
      kCapacity: capacity,
      kOcupancy: ocupancy,
      kTimestamp: timestamp.toIso8601String(),
      kLocationNavigation: locationNav,
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.isEmpty || name.length > 30) results.add(CSMSetValidationResult(kName, "Name must be 25 max lenght and non-empty", "strictLength(1,30)"));
    if(yard < 0) results.add(CSMSetValidationResult(kYard, 'Yard pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

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
   
    return Section(id ?? this.id, status ?? this.status, yard ?? this.yard, name ?? this.name, capacity ?? this.capacity, ocupancy ?? this.ocupancy,
    locationNavigation ?? this.locationNavigation, statusNavigation ?? this.statusNavigation);
  }

}

final class SectionDecoder implements CSMDecodeInterface<Section> {
  const SectionDecoder();

  @override
  Section decode(JObject json) {
    return Section.des(json);
  }
}
