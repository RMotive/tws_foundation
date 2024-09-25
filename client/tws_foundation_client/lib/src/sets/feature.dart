import 'package:csm_client/csm_client.dart';

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
