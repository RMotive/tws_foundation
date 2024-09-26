import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class LoadType implements CSMSetInterface {
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  String name = "";
  String? description;

  LoadType(this.id, this.name, this.description);

  LoadType.a();
  factory LoadType.des(JObject json) {
    int id = json.get(SCK.kId);
    String name = json.get(SCK.kName);
    String? description = json.getDefault(SCK.kDescription, null);

    return LoadType(id, name, description);
  }

  LoadType clone({int? id, int? status, String? name, String? description, Status? statusNavigation, List<Truck>? trucks}) {
    String? desc = description ?? this.description;
    if (desc == "") desc = null;
    return LoadType(id ?? this.id, name ?? this.name, desc);
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
