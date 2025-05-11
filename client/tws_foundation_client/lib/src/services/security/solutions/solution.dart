import 'package:csm_client/csm_client.dart';

final class Solution extends NamedEntityB<Solution> {
  static const String kSign = 'sign';

  String sign = '';

  /// Generates a new [Solution] instance from mandatory values.
  Solution();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
        kSign: sign,
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    sign = encode.get(kSign);
  }

  @override
  List<EntityInvalidation<Solution>> evaluate() {
    List<EntityInvalidation<Solution>> results = <EntityInvalidation<Solution>>[];

    if (name.isEmpty) results.add(EntityInvalidation<Solution>(this, PropertyInfo('Name', String, name), 'Solution name can\'t be empty', 'notEmpty'));
    // if (sign.length != 5) results.add(EntityInvalidation(kSign, 'Solution sign must be 5 length', 'strictLength(5)'));
    return results;
  }

}
