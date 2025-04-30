import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/filters/set_view_filter_node_interface.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_order_options.dart';

///
final class SetViewInput<TSet extends EntityI<TSet>> implements EncodableI {
  ///
  final bool retroactive;

  ///
  final int range;

  ///
  final int page;

  ///
  final DateTime? creation;

  ///
  final List<SetViewOrderOptions> orderings;

  ///
  final List<SetViewFilterNodeInterface<TSet>> filters;

  ///
  const SetViewInput(this.retroactive, this.range, this.page, this.creation, this.orderings, this.filters);

  @override
  DataMap encode() {
    return <String, dynamic>{
      'retroactive': retroactive,
      'range': range,
      'page': page,
      'creation': creation,
      'orderings': orderings.map((SetViewOrderOptions i) => i.encode()).toList(),
      'filters': filters.map((SetViewFilterNodeInterface<TSet> i) => i.encode()).toList(),
    };
  }
}
