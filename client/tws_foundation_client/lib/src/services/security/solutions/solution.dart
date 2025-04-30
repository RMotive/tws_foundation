import 'package:csm_client/csm_client.dart';

///
final class Solution extends NamedEntityB<Solution> {
  ///
  String sign = '';

  Solution();
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    name = encode.get('name');
    sign = encode.get('sign');
    description = encode.get('description');
  }
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        'name': name,
        'sign': sign,
        'description': description,
      },
    );
  }
  
  @override
  List<EntityInvalidation<Solution>> evaluate() {
    return <EntityInvalidation<Solution>>[];
  }
}
