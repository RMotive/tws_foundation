import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/src/models/interfaces/set_view_filter_interface.dart';

final class SetViewDateFilter<TSet extends CSMSetInterface> implements SetViewFilterInterface<TSet> {
  @override
  final String discrimination = 'SetViewDateFilter<TSet>';

  ///
  @override
  final String property;

  ///
  @override
  final int order;

  final DateTime from;

  final DateTime? to;

  ///
  const SetViewDateFilter(
    this.order,
    this.from,
    this.to, {
    this.property = 'Timestamp',
  });

  @override
  JObject encode() {
    return <String, dynamic>{
      'discrimination': discrimination,
      'property': property,
      'order': order,
      'from': from.toIso8601String(),
      'to': to?.toIso8601String(),
    };
  }
}
