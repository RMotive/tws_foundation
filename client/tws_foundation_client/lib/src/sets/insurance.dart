import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Insurance implements CSMSetInterface {
  @override
  int id;
  String policy;
  DateTime expiration;
  String country;
  List<Truck> trucks;

  Insurance(this.id, this.policy, this.expiration, this.country, this.trucks);
  factory Insurance.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    String policy = json.get('policy');
    DateTime expiration = json.get('expiration');
    String country = json.get('country');

    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();

    return Insurance(id, policy, expiration, country, trucks);
  }

  @override
  JObject encode() {
    String e = expiration.toString().substring(0, 10);

    return <String, dynamic>{
      'id': id,
      'policy': policy,
      'expiration': e,
      'country': country,
      'trucks': trucks.map((Truck i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    throw UnimplementedError();
  }
}

final class InsuranceDecoder implements CSMDecodeInterface<Insurance> {
  const InsuranceDecoder();

  @override
  Insurance decode(JObject json) {
    return Insurance.des(json);
  }
}
