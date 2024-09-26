import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Maintenance implements CSMSetInterface {
  static const String kAnual = "anual";
  static const String kTrimestral = "trimestral";
  static const String kStatus = "status";
  static const String kstatusNavigation = "StatusNavigation";
  static const String kTrucks = "trucks";

  @override
  int id = 0;
  int status = 1;
  DateTime anual = DateTime.now();
  DateTime trimestral = DateTime.now();
  Status? statusNavigation;
  List<Truck> trucks = <Truck>[];

  Maintenance(this.id, this.status, this.anual, this.trimestral, this.statusNavigation, this.trucks);

  Maintenance.a();

  factory Maintenance.des(JObject json) {
    List<Truck> trucks = <Truck>[];

    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    DateTime anual = json.get(kAnual);
    DateTime trimestral = json.get(kTrimestral);
    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
    List<JObject> rawTrucksArray = json.getList(kTrucks);
    trucks = rawTrucksArray.map<Truck>(Truck.des).toList();
    return Maintenance(id, status, anual, trimestral, statusNavigation, trucks);
  }

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

  @override
  JObject encode() {
    String a = anual.toString().substring(0, 10);
    String t = trimestral.toString().substring(0, 10);
    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kAnual: a,
      kTrimestral: t,
      kstatusNavigation: statusNavigation,
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    return <CSMSetValidationResult>[];
  }
}
