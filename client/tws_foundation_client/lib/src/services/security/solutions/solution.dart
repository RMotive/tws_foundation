import 'package:csm_client/csm_client.dart';

final class Solution extends NamedEntityB<Solution> {
  static const String kName = 'name';
  static const String kSign = 'sign';
  static const String kDescription = 'description';

  String sign = '';

  /// Generates a new [Solution] instance from mandatory values.
  Solution();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
        kName: name,
        kSign: sign,
        kDescription: description,
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    name = encode.get('name');
    sign = encode.get('sign');
    description = encode.get('description');
  }

  @override
  List<EntityInvalidation<Solution>> evaluate() {
    List<EntityInvalidation<Solution>> results = <EntityInvalidation<Solution>>[];

    // if (name.isEmpty) results.add(EntityInvalidation<Solution>(this, get, 'Solution name can\'t be empty', 'notEmpty'));
    // if (sign.length != 5) results.add(EntityInvalidation(kSign, 'Solution sign must be 5 length', 'strictLength(5)'));
    return results;
  }

}
