import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class SetViewOptions<TSet extends CSMSetInterface> implements CSMEncodeInterface {
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
  const SetViewOptions(this.retroactive, this.range, this.page, this.creation, this.orderings, this.filters);

  @override
  JObject encode() {
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
