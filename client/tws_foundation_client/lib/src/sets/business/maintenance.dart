import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Maintenance implements CSMSetInterface {
  static const String kAnual = "anual";
  static const String kTrimestral = "trimestral";
  static const String kTrucks = "trucks";
  
  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  @override
  int id = 0;
  int status = 1;
  DateTime anual = DateTime(0);
  DateTime trimestral = DateTime(0);
  Status? statusNavigation;
  List<Truck> trucks = <Truck>[];

  Maintenance(this.id, this.status, this.anual, this.trimestral, this.statusNavigation, this.trucks, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Maintenance.des(JObject json) {
    List<Truck> trucks = <Truck>[];

    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    DateTime anual = json.get(kAnual);
    DateTime trimestral = json.get(kTrimestral);
    DateTime timestamp = json.get(SCK.kTimestamp);
    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>(Truck.des).toList();
    return Maintenance(id, status, anual, trimestral, statusNavigation, trucks, timestamp: timestamp);
  }

  @override
  JObject encode() {
    String a = anual.toString().substring(0,10);
    String t = trimestral.toString().substring(0,10);
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kAnual: a,
      kTrimestral:t,
      SCK.kTimestamp: timestamp.toIso8601String(),
      SCK.kStatusNavigation: statusNavigation,
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }  
  
  @override
  List<CSMSetValidationResult> evaluate() {    
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(trimestral == DateTime(0)) results.add(CSMSetValidationResult(kTrimestral, 'Trimestral maintenance invalid value.', 'invalidDate()'));
    if(anual == DateTime(0)) results.add(CSMSetValidationResult(kAnual, 'Anual maintenance invalid value.', 'invalidDate()'));

    return results;
  }
  Maintenance.a();
  Maintenance clone({
    int? id,
    int? status,
    DateTime? anual,
    DateTime? trimestral,
    Status? statusNavigation,
    List<Truck>? trucks,
  }) {
    return Maintenance(
      id ?? this.id,
      status ?? this.status,
      anual ?? this.anual,
      trimestral ?? this.trimestral,
      statusNavigation ?? this.statusNavigation,
      trucks ?? this.trucks,
    );
  }
}
