import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Situation] catalog entry information, handles information of a catalog entry of [Situation]s describes
/// a situation for a [Truck] like ready for usage, or in maintenance as example.
final class Situation implements CSMSetInterface {
  /// [status] property key.
  static const String kStatus = "status";

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreign relation [Status] pointer.
  int status = 1;

  /// Entry name/label.
  String name = "";

  /// Descriptive usage.
  String? description;

  /// Foreign relation [Status] object.
  Status? statusNavigation;

  /// List of [Truck] in the current [Situation].
  List<Truck> trucks = <Truck>[];

  /// Crates a [Situation] object with required properties-
  Situation(this.id, this.name, this.description);

  /// Creates a [Situation] object with default properties.
  Situation.a();

  /// Creates a [Situation] object based on a given [json] object.
  factory Situation.des(JObject json) {
    int id = json.get(SCK.kId);
    String name = json.get(SCK.kName);
    String? description = json.getDefault(SCK.kName, null);

    return Situation(id, name, description);
  }

  /// Creates a [Situation] object overriding the given properties.
  Situation clone({
    int? id,
    int? status,
    String? name,
    String? description,
  }) {
    String? desc = description ?? this.description;
    if (desc == "") desc = null;
    return Situation(
      id ?? this.id,
      name ?? this.name,
      desc,
    );
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kName: name,
      SCK.kDescription: description,
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (name.isEmpty || name.length > 25) results.add(CSMSetValidationResult(SCK.kName, "Name must be 25 max lenght and non-empty", "strictLength(1,25)"));
    return results;
  }
}
