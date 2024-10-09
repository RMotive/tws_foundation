import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Maintenance implements CSMSetInterface {
  static const String kAnual = "anual";
  static const String kTrimestral = "trimestral";
  static const String kStatus = "status";
  static const String kTimestamp = "timestamp";
  static const String kstatusNavigation = "StatusNavigation";
  static const String kTrucks = "trucks";
  
  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  @override
  int id = 0;
  int status = 1;
  DateTime anual = DateTime.now();
  DateTime trimestral = DateTime.now();
  Status? statusNavigation;
  List<Truck> trucks = <Truck>[];

  Maintenance(this.id, this.status, this.anual, this.trimestral, this.statusNavigation, this.trucks, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Maintenance.des(JObject json) {
    List<Truck> trucks = <Truck>[];

    int id = json.get('id');
    int status = json.get('status');
    DateTime anual = json.get('anual');
    DateTime trimestral = json.get('trimestral');
    DateTime timestamp = json.get('timestamp');
    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
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
      'id': id,
      kStatus: status,
      kAnual: a,
      kTrimestral:t,
      kTimestamp: timestamp.toIso8601String(),
      kstatusNavigation: statusNavigation,
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }  
  
  @override
  List<CSMSetValidationResult> evaluate() {
    return <CSMSetValidationResult>[];
  }
  Maintenance.def();
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
