import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class VehiculeModel implements CSMSetInterface {
  static const String kYear = "year";
  static const String kManufacturer = "manufacturer";
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
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int manufacturer = json.get(kManufacturer);
    String name = json.get(SCK.kName);
    DateTime year = json.get(kYear);
    DateTime timestamp = json.get(SCK.kTimestamp);
    Status? statusNavigation;
    Manufacturer? manufacturerNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    if (json[kmanufacturerNavigation] != null) {
      JObject rawNavigation = json.getDefault(kmanufacturerNavigation, <String, dynamic>{});
      manufacturerNavigation = Manufacturer.des(rawNavigation);
    }
        
    return VehiculeModel(id, status, manufacturer, name, year, statusNavigation, manufacturerNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    String e = year.toString().substring(0, 10);
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kManufacturer: manufacturer,
      SCK.kName: name,
      kYear: e,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kmanufacturerNavigation: manufacturerNavigation?.encode(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.trim().isEmpty || name.length > 32) results.add(CSMSetValidationResult(SCK.kName, "Max name length is 32 characters", "strictLength(1,32)"));
    
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
    
    if(manufacturer == 0){
      this.manufacturerNavigation = null;
      manufacturerNavigation = null;
    }

    return VehiculeModel(
      id ?? this.id, 
      status ?? this.status, 
      manufacturer ?? this.manufacturer,
      name ?? this.name, 
      year ?? this.year, 
      statusNavigation ?? this.statusNavigation, 
      manufacturerNavigation ?? this.manufacturerNavigation
    );
  }
}
