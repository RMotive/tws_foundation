import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/src/models/interfaces/set_view_filter_interface.dart';
import 'package:tws_foundation_client/src/models/interfaces/set_view_filter_node_interface.dart';

///
final class SetViewFilterLinearEvaluation<TSet extends CSMSetInterface> implements SetViewFilterNodeInterface<TSet> {
  ///
  @override
  final String discrimination = 'CSM_Foundation.Database.Models.Options.Filters.SetViewFilterLinearEvaluation`1[TSet]';

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
      'operator': operator,
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
