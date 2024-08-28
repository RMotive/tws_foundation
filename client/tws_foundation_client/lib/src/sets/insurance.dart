import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Insurance implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kPolicy = "policy";
  static const String kExpiration = "expiration";
  static const String kCountry = "country";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTrucks = "trucks";

  @override
  int id = 0;
  int status = 0;
  String policy = "";
  DateTime expiration = DateTime.now();
  String country = "";
  Status? statusNavigation;
  List<Truck> trucks = <Truck>[];

  Insurance(this.id, this.status, this.policy, this.expiration, this.country, this.statusNavigation, this.trucks);
  factory Insurance.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    int status = json.get('status');
    String policy = json.get('policy');
    DateTime expiration = json.get('expiration');
    String country = json.get('country');
    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();
    
    return Insurance(id, status, policy, expiration, country, statusNavigation,trucks);
  }

  @override
  JObject encode() {
    String e = expiration.toString().substring(0, 10);

    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kPolicy: policy,
      kExpiration: e,
      kCountry: country,
      kstatusNavigation: statusNavigation?.encode(),
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(policy.length > 20) results.add(CSMSetValidationResult(kPolicy, "Policy must be 20 length", "strictLength(20)"));
    if(country.length<2 && country.length>3) results.add(CSMSetValidationResult(kCountry,"Country must be between 2 and 3 length", "strictLength(2,3)"));

    return results;
  }
  Insurance.def();

  Insurance clone({
    int? id,
    int? status,
    String? policy,
    DateTime? expiration,
    String? country,
    Status? statusNavigation,
    List<Truck>? trucks
  }){
    return Insurance(id ?? this.id, status ?? this.status, policy ?? this.policy, expiration ?? this.expiration, country ?? this.country, statusNavigation ?? this.statusNavigation, trucks ?? this.trucks);
  }
  
}

final class InsuranceDecoder implements CSMDecodeInterface<Insurance> {
  const InsuranceDecoder();

  @override
  Insurance decode(JObject json) {
    return Insurance.des(json);
  }
}
