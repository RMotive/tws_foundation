import 'package:csm_foundation_services/csm_foundation_services.dart';

final class Feature implements CSMEncodeInterface {
  final int id;
  final String name;
  final String? description;

  const Feature(this.id, this.name, this.description);

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
