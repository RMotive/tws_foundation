import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Manufacturer implements CSMSetInterface {
  @override
  int id;
  final String model;
  final String brand;
  final DateTime year;
  final List<Truck>? trucks;

  Manufacturer(this.id, this.model, this.brand, this.year, this.trucks);
  factory Manufacturer.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    String model = json.get('model');
    String brand = json.get('brand');
    DateTime year = json.get('year');

    //Validate if the first position is not null for non-empty Truck lists.
    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();

    return Manufacturer(id, model, brand, year, trucks);
  }

  @override
  JObject encode() {
    String y = year.toString().substring(0, 10);
    return <String, dynamic>{
      'id': id,
      'model': model,
      'brand': brand,
      'year': y,
      'Trucks': trucks?.map((Truck i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    // TODO: implement evaluate
    throw UnimplementedError();
  }
}

final class ManufacturerDecoder implements CSMDecodeInterface<Manufacturer> {
  const ManufacturerDecoder();

  @override
  Manufacturer decode(JObject json) {
    return Manufacturer.des(json);
  }
}
