import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Catalog information for [Manufacturer], handles information of a [Truck] manufacturer.
final class Manufacturer implements CSMSetInterface {
  /// [model] property key.
  static const String kModel = "model";

  /// [brand] property key.
  static const String kBrand = "brand";

  /// [year] property key.
  static const String kYear = "year";

  /// [trucks] property key.
  static const String kTrucks = "trucks";

  /// Record database pointer.
  @override
  int id = 0;

  /// Model identifier.
  String model = '';

  /// Brand identifier.
  String brand = '';

  /// Manufacture year.
  DateTime year = DateTime(1000);

  /// List of [Truck] that has the current [Manufacturer].
  List<Truck>? trucks;

  /// Creates a [Manufacturer] object with required properties.
  Manufacturer(this.id, this.model, this.brand, this.year, this.trucks);

  /// Creates a [Manufacturer] object with refault properties.
  Manufacturer.def();

  /// Creates a [Manufacturer] object based on the given [json] object.
  factory Manufacturer.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get(SCK.kId);
    String model = json.get(kModel);
    String brand = json.get(kBrand);
    DateTime year = json.get(kYear);

    //Validate if the first position is not null for non-empty Truck lists.
    List<JObject> rawTrucksArray = json.getList(kTrucks);
    trucks = rawTrucksArray.map<Truck>(Truck.des).toList();

    return Manufacturer(id, model, brand, year, trucks);
  }

  /// Creates a [Manufacturer] object overriding the given properties.
  Manufacturer clone({int? id, String? model, String? brand, DateTime? year}) {
    return Manufacturer(id ?? this.id, model ?? this.model, brand ?? this.brand, year ?? this.year, trucks);
  }

  @override
  JObject encode() {
    String y = year.toString().substring(0, 10);
    return <String, dynamic>{
      SCK.kId: id,
      kModel: model,
      kBrand: brand,
      kYear: y,
      kTrucks: trucks?.map((Truck i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (kModel.length > 30) results.add(CSMSetValidationResult(kModel, "Model length must be a max lenght of 30", "strictLength(1,30)"));
    if (kModel.length > 15) results.add(CSMSetValidationResult(kBrand, "Brand length must be a max lenght of 15", "strictLength(1,15)"));

    return results;
  }
}
