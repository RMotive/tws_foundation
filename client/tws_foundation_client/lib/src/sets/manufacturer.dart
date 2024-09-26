import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Manufacturer implements CSMSetInterface {
  static const String kModel = "model";
  static const String kBrand = "brand";
  static const String kYear = "year";
  static const String kTimestamp = "timestamp";
  static const String kTrucks = "trucks";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id;
  String model;
  String brand;
  DateTime year;
  List<Truck>? trucks;

  Manufacturer(this.id, this.model, this.brand, this.year, this.trucks, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Manufacturer.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    String model = json.get('model');
    String brand = json.get('brand');
    DateTime year = json.get('year');
    DateTime timestamp = json.get('timestamp');

   //Validate if the first position is not null for non-empty Truck lists.
    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();
    
   
   
    return Manufacturer(id, model, brand, year, trucks, timestamp: timestamp);
  }

  @override
  JObject encode() {

    String y = year.toString().substring(0,10);
    return <String, dynamic>{
      'id': id,
      kModel: model,
      kBrand: brand,
      kYear: y,
      kTimestamp: timestamp.toIso8601String(),
      kTrucks: trucks?.map((Truck i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(kModel.length > 30) results.add(CSMSetValidationResult(kModel, "Model length must be a max lenght of 30", "strictLength(1,30)"));
    if(kModel.length > 15) results.add(CSMSetValidationResult(kBrand, "Brand length must be a max lenght of 15", "strictLength(1,15)"));

    return results;
  }

  Manufacturer clone({
    int? id,
    String? model,
    String? brand,
    DateTime? year
  }){
    return Manufacturer(id ?? this.id, model ?? this.model, brand ?? this.brand, year ?? this.year, trucks);
  }

}

final class ManufacturerDecoder implements CSMDecodeInterface<Manufacturer> {
  const ManufacturerDecoder();

  @override
  Manufacturer decode(JObject json) {
    return Manufacturer.des(json);
  }
}
