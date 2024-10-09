import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/models/interfaces/set_view_filter_interface.dart';

///
final class SetViewPropertyFilter<TSet extends CSMSetInterface> implements SetViewFilterInterface<TSet> {
  @override
  final String discrimination = 'SetViewPropertyFilter`1';

  ///
  @override
  final int order;

  ///
  @override
  final String property;

  ///
  final SetViewFilterEvaluations evaluation;

  ///
  final Object? value;

  ///
  SetViewPropertyFilter(this.order, this.evaluation, this.property, this.value);

  @override
  JObject encode() {
    return <String, dynamic>{
      'discrimination': discrimination,
      'order': order,
      'property': property,
      'evaluation': evaluation.index,
      'value': value?.toString(),
    };
  }
}

///
enum SetViewFilterEvaluations {
  ///
  equal,

  ///
  contians,

  ///
  lessThan,

  ///
  lessThanEqual,

  ///
  greaterThan,

  ///
  greaterThanEqual,
}
