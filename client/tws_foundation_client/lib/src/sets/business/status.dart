import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Status catalogue entry information, handles information of a status catalogue record.
final class Status implements CSMSetInterface {
  /// [trucks] property key.
  static const String kTrucks = "trucks";

  /// Record database pointer.
  @override
  int id = 0;

  /// Catalog name/label identification.
  String name = "";

  /// Catalog record description.
  String? description;

  /// Trucks with the current [Status].
  List<Truck> trucks = <Truck>[];

  /// Creates a new [Status] object with required properties.
  Status(this.id, this.name, this.description, this.trucks);

  /// Creates a new [Status] object with default properties.
  Status.def();

  /// Creaes a [Status] object based on a given [json] object.
  factory Status.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get(SCK.kId);
    String name = json.get(SCK.kName);
    String? description = json.getDefault(SCK.kDescription, null);
    List<JObject> rawTrucksArray = json.getList(kTrucks);
    trucks = rawTrucksArray
        .map<Truck>(
          (JObject json) => Truck.des(json),
        )
        .toList();

    return Status(id, name, description, trucks);
  }

  /// Creates a [Status] object overriding the given properties.
  Status clone({
    int? id,
    String? name,
    String? description,
    List<Truck>? trucks,
  }) {
    return Status(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      trucks ?? this.trucks,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kName: name,
      SCK.kDescription: description,
      kTrucks: trucks
          .map(
            (Truck i) => i.encode(),
          )
          .toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (name.length > 25) results.add(CSMSetValidationResult(SCK.kName, "Name must be 25 length", "structLength(25)"));
    if (description != null && description!.length > 150) results.add(CSMSetValidationResult(SCK.kDescription, "Description must be 150 max length", "structLength(0,150)"));
    return results;
  }
}
