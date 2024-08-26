import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class SCT implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kType = "type";
  static const String kNumber = "number";
  static const String kConfiguration = "configuration";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTrucks = "trucks";

  @override
  int id = 0;
  int status = 0;
  String type = "";
  String number = "";
  String configuration = "";
  Status? statusNavigation;
  List<Truck> trucks = <Truck>[];

  SCT(this.id, this.status, this.type, this.number, this.configuration, this.statusNavigation ,this.trucks);
  factory SCT.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    int status = json.get('status');
    String type = json.get('type');
    String number = json.get('number');
    String configuration = json.get('configuration');

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();
    
    return SCT(id, status, type, number, configuration, statusNavigation, trucks);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kType: type,
      kNumber: number,
      kConfiguration: configuration,
      kstatusNavigation: statusNavigation?.encode(),
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(type.length != 6) results.add(CSMSetValidationResult(kType, "Type must be 6 length", "strictLength(6)"));
    if(number.length != 25) results.add(CSMSetValidationResult(kNumber, "Number must be 25 length", "structLength(25)"));
    if(configuration.length < 6 || configuration.length > 10) results.add(CSMSetValidationResult(kConfiguration, "Configuration must be between 6 and 10 length", "strictLength(6,10)"));
    
    return results;
  }

  SCT clone({
    int? id,
    int? status,
    String? type,
    String? number,
    String? configuration,
    Status? statusNavigation,
    List<Truck>? trucks
  }){
    return SCT(id ?? this.id, status ?? this.status, type ?? this.type, number ?? this.number, configuration ?? this.configuration, statusNavigation ?? this.statusNavigation, trucks ?? this.trucks);
  }
}

final class SCTDecoder implements CSMDecodeInterface<SCT> {
  const SCTDecoder();

  @override
  SCT decode(JObject json) {
    return SCT.des(json);
  }
}
