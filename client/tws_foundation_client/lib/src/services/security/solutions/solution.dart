import 'package:csm_client/csm_client.dart';


///
Solution solutionBuilder() => Solution();

/// {implementation} class for an [EntityI].
///
///
/// Defines a business entity that stores information about a [Solution] implementation along the whole business ecosystem, a [Solution] is an object identification for a
/// [ServerI] or a user view application that have different data handling contexts.
final class Solution extends NamedEntityB<Solution> { 
  /// Specific identification sign.
  String sign = '';

  /// Creates a new [Solution] instance.
  Solution();
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    sign = encode.get('sign');
  }
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        'sign': sign,
      },
    );
  }

  @override
  List<EntityInvalidation<Solution>> evaluate() {
    List<EntityInvalidation<Solution>> results = <EntityInvalidation<Solution>>[];

    if (name.isEmpty) results.add(EntityInvalidation<Solution>(this, PropertyInfo('Name', String, name), 'Solution name can\'t be empty', 'notEmpty'));
    // if (sign.length != 5) results.add(EntityInvalidation(kSign, 'Solution sign must be 5 length', 'strictLength(5)'));
    return results;
  }

}
