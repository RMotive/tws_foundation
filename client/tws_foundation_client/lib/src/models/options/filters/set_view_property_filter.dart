import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/src/models/interfaces/set_view_filter_interface.dart';

///
final class SetViewPropertyFilter<TSet extends CSMSetInterface> implements SetViewFilterInterface<TSet> {
  @override
  final String discrimination = 'SetViewProeprtyFilter<TSet>';

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
      'evaluation': evaluation,
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
