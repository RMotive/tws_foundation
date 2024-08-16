import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Situation implements CSMSetInterface {
  @override
  int id;
  String name;
  String? description;
  List<Truck> trucks;

  Situation(this.id, this.name, this.description, this.trucks);
  factory Situation.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    String name = json.get('name');
    String? description = json.getDefault('description', null);

    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();

    return Situation(id, name, description, trucks);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'trucks': trucks.map((Truck i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    // TODO: implement evaluate
    throw UnimplementedError();
  }
}

final class SituationDecoder implements CSMDecodeInterface<Situation> {
  const SituationDecoder();

  @override
  Situation decode(JObject json) {
    return Situation.des(json);
  }
}
