import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class VehiculeModel implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kName = "name";
  static const String kYear = "year";
  static const String kManufacturer = "manufacturer";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kmanufacturerNavigation = 'ManufacturerNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  int manufacturer = 0;
  String name = "";
  DateTime year = DateTime.now();
  Status? statusNavigation;
  Manufacturer? manufacturerNavigation;

  VehiculeModel(this.id, this.status, this.manufacturer, this.name, this.year, this.statusNavigation, this.manufacturerNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory VehiculeModel.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int manufacturer = json.get('manufacturer');
    String name = json.get('name');
    DateTime year = json.get('year');
    DateTime timestamp = json.get('timestamp');
    Status? statusNavigation;
    Manufacturer? manufacturerNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    if (json['ManufacturerNavigation'] != null) {
      JObject rawNavigation = json.getDefault('ManufacturerNavigation', <String, dynamic>{});
      manufacturerNavigation = deserealize<Manufacturer>(rawNavigation, decode: ManufacturerDecoder());
    }
        
    return VehiculeModel(id, status, manufacturer, name, year, statusNavigation, manufacturerNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    String e = year.toString().substring(0, 10);
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kManufacturer: manufacturer,
      kName: name,
      kYear: e,
      kTimestamp: timestamp.toIso8601String(),
      kmanufacturerNavigation: manufacturerNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.trim().isEmpty || name.length > 32) results.add(CSMSetValidationResult(kName, "Max name length is 32 characters", "strictLength(1,32)"));
    
    return results;
  }
  VehiculeModel.def();
  VehiculeModel clone({
    int? id,
    int? status,
    int? manufacturer,
    String? name,
    DateTime? year,
    Status? statusNavigation,
    Manufacturer? manufacturerNavigation
  }){
    return VehiculeModel(id ?? this.id, status ?? this.status, manufacturer ?? this.manufacturer, name ?? this.name, year ?? this.year, statusNavigation ?? this.statusNavigation, manufacturerNavigation ?? this.manufacturerNavigation);
  }
}

final class VehiculeModelDecoder implements CSMDecodeInterface<VehiculeModel> {
  const VehiculeModelDecoder();

  @override
  VehiculeModel decode(JObject json) {
    return VehiculeModel.des(json);
  }
}
