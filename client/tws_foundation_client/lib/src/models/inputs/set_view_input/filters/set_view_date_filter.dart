import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class SetViewDateFilter<TEntity extends EntityI> implements SetViewFilterInterface<TEntity> {
  @override
  final String discrimination = 'SetViewDateFilter`1';

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
