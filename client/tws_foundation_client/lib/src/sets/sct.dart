import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class SCT implements CSMSetInterface {
  @override
  int id;
  final String type;
  final String number;
  final String configuration;
  final List<Truck> trucks;

  SCT(this.id, this.type, this.number, this.configuration, this.trucks);
  factory SCT.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    String type = json.get('type');
    String number = json.get('number');
    String configuration = json.get('configuration');

    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();

    return SCT(id, type, number, configuration, trucks);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'number': number,
      'configuration': configuration,
      'trucks': trucks.map((Truck i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    // TODO: implement evaluate
    throw UnimplementedError();
  }
}

final class SCTDecoder implements CSMDecodeInterface<SCT> {
  const SCTDecoder();

  @override
  SCT decode(JObject json) {
    return SCT.des(json);
  }
}
