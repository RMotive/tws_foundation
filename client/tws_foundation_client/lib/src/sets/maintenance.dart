import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Maintenance implements CSMSetInterface {
  static const String kAnual = "anual";
  static const String kTrimestral = "trimestral";
  static const String kStatus = "status";
  static const String kstatusNavigation = "StatusNavigation";
  static const String kTrucks = "trucks";
  
  @override
  int id = 0;
  int status = 0;
  DateTime anual = DateTime.now();
  DateTime trimestral = DateTime.now();
  Status? statusNavigation;
  List<Truck> trucks = <Truck>[];

  Maintenance(this.id, this.status, this.anual, this.trimestral, this.statusNavigation, this.trucks);
  factory Maintenance.des(JObject json) {
    List<Truck> trucks = <Truck>[];

    int id = json.get('id');
    int status = json.get('status');
    DateTime anual = json.get('anual');
    DateTime trimestral = json.get('trimestral');
    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();
    return Maintenance(id, status, anual, trimestral, statusNavigation, trucks);
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
    List<Truck>? trucks
  }){
    return Maintenance(id ?? this.id, status ?? this.status, anual ?? this.anual, trimestral ?? this.trimestral, statusNavigation ?? this.statusNavigation, trucks ?? this.trucks);
  }
}

final class MaintenanceDecoder implements CSMDecodeInterface<Maintenance> {
  const MaintenanceDecoder();

  @override
  Maintenance decode(JObject json) {
    return Maintenance.des(json);
  }
}
