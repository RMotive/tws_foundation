import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Status implements CSMSetInterface {
  /// [trucks] property key.
  static const String kTrucks = "trucks";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Record database pointer.
  @override
  int id = 0;

  /// Catalog name/label identification.
  String name = "";

  /// Catalog record description.
  String? description;

  /// Trucks with the current [Status].
  List<Truck> trucks = <Truck>[];

  /// Creates a new [Status] object with default properties.
  Status.a();

  /// Creaes a [Status] object based on a given [json] object.
  Status(this.id, this.name, this.description, this.trucks, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Status.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get(SCK.kId);
    String name = json.get(SCK.kName);
    String? description = json.getDefault(SCK.kDescription, null);
    DateTime timestamp = json.get(SCK.kTimestamp);
    List<JObject> rawTrucksArray = json.getList(kTrucks);
    trucks = rawTrucksArray
        .map<Truck>(
          (JObject json) => Truck.des(json),
        )
        .toList();

    return Status(id, name, description, trucks, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kName: name,
      SCK.kDescription: description,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.length >25) results.add(CSMSetValidationResult(SCK.kName, "Name must be 25 length", "structLength(25)"));
    if(description != null && description!.length > 150) results.add(CSMSetValidationResult(SCK.kDescription, "Description must be 150 max length", "structLength(0,150)"));
    return results;
  }
  Status clone({
    int? id,
    String? name,
    String? description,
    List<Truck>? trucks
  }){
    return Status(
      id ?? this.id, 
      name ?? this.name, 
      description ?? this.description, 
      trucks ?? this.trucks
    );
  }
}

