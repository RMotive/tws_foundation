import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Maintenance implements CSMSetInterface {
  @override
  int id;
  final DateTime anual;
  final DateTime trimestral;
  final List<Truck> trucks;

  Maintenance(this.id, this.anual, this.trimestral, this.trucks);
  factory Maintenance.des(JObject json) {
    List<Truck> trucks = <Truck>[];

    int id = json.get('id');
    DateTime anual = json.get('anual');
    DateTime trimestral = json.get('trimestral');
    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();
    return Maintenance(id, anual, trimestral, trucks);
  }

  @override
  JObject encode() {
    String a = anual.toString().substring(0, 10);
    String t = trimestral.toString().substring(0, 10);
    return <String, dynamic>{
      'id': id,
      'anual': a,
      'trimestral': t,
      'trucks': trucks.map((Truck i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    // TODO: implement evaluate
    throw UnimplementedError();
  }
}

final class MaintenanceDecoder implements CSMDecodeInterface<Maintenance> {
  const MaintenanceDecoder();

  @override
  Maintenance decode(JObject json) {
    return Maintenance.des(json);
  }
}
