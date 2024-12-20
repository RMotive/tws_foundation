import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/models/interfaces/set_view_filter_interface.dart';
import 'package:tws_foundation_client/src/models/interfaces/set_view_filter_node_interface.dart';

///
final class SetViewFilterLinearEvaluation<TSet extends CSMSetInterface> implements SetViewFilterNodeInterface<TSet> {
  ///
  @override
  final String discrimination = 'SetViewFilterLinearEvaluation`1';

  ///
  @override
  final int order;

  ///
  final SetViewFilterEvaluationOperators operator;

  ///
  final List<SetViewFilterInterface<TSet>> filters;

  ///
  SetViewFilterLinearEvaluation(this.order, this.operator, this.filters);

  @override
  JObject encode() {
    return <String, dynamic>{
      'discrimination': discrimination,
      'order': order,
      'operator': operator.index,
      'filters': filters.map((SetViewFilterInterface<TSet> i) => i.encode()).toList(),
    };
  }
}

///
enum SetViewFilterEvaluationOperators {
  ///
  or,

  ///
  and,
}
