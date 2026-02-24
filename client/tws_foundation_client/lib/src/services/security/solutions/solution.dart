import 'package:csm_client_core/csm_client_core.dart';


///
Solution solutionBuilder() => Solution();

/// {implementation} class for an [IEntity].
///
///
/// Defines a business entity that stores information about a [Solution] implementation along the whole business ecosystem, a [Solution] is an object identification for a
/// [IServer] or a user view application that have different data handling contexts.
final class Solution extends NamedEntityBase<Solution> { 
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
  List<EntityErrors<Solution>> evaluate(List<EntityErrors<Solution>> errors) {
    errors = super.evaluate(errors);

    if (name.isEmpty) errors.add(EntityErrors<Solution>(this, PropertyInfo('Name', String, name), 'Solution name can\'t be empty', 'notEmpty'));
    // if (sign.length != 5) errors.add(EntityErrors(kSign, 'Solution sign must be 5 length', 'strictLength(5)'));
    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Solution ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    if (sign != ref.sign) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo('sign', String, sign),
          sign,
          ref.sign,
          null,
        ),
      );
    }

    return aggregated;
  }
}
