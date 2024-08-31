import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Status implements CSMSetInterface {
  static const String kName = "name";
  static const String kDescription = "description";
  static const String kTrucks = "trucks";

  @override
  int id = 0;
  String name = "";
  String? description;
  List<Truck> trucks = <Truck>[];

  Status(this.id, this.name, this.description, this.trucks);
  factory Status.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    String name = json.get('name');
    String? description = json.getDefault('description', null);
    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();
    
    return Status(id, name, description, trucks);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kName: name,
      kDescription: description,
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.length >25) results.add(CSMSetValidationResult(kName, "Name must be 25 length", "structLength(25)"));
    if(description != null && description!.length > 150) results.add(CSMSetValidationResult(kDescription, "Description must be 150 max length", "structLength(0,150)"));
    return results;
  }
  Status.def();
  Status clone({
    int? id,
    String? name,
    String? description,
    List<Truck>? trucks
  }){
    return Status(id ?? this.id, name ?? this.name, description ?? this.description, trucks ?? this.trucks);
  }
}

final class StatusDecoder implements CSMDecodeInterface<Status> {
  const StatusDecoder();

  @override
  Status decode(JObject json) {
    return Status.des(json);
  }
}
