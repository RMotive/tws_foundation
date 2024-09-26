import 'package:csm_client/csm_client.dart';

final class Feature implements CSMEncodeInterface {
  int id = 0;
  String name = '';
  String? description;

  Feature(this.id, this.name, this.description);

  Feature.a();

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
