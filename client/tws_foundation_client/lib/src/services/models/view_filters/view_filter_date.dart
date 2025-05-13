import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {implementation} class for [ViewFilterDate].
///
/// Defines a final behavior implementation from [ViewFilterI], that represents a data filtering for the {View} operation
/// based on a [DateTime] threshold.
///
///
/// [T] type of the [EntityI] impolementation the filter will be applied to.
///
final class ViewFilterDate<T extends EntityI<T>> implements ViewFilterI<T> {
  @override
  String discriminator = '';

  @override
  String property = EntityKeys.timestamp;

  @override
  int order = 0;

  /// Initial [DateTime] threshold.
  DateTime from = DateTime.now().toUtc();

  /// Final [DateTime] threshold.
  DateTime? to;

  /// Creates a new [ViewFilterDate] instance.
  ViewFilterDate();

  @override
  DataMap encode() {
    return <String, dynamic>{
      EntityKeys.discriminator: discriminator,
      'property': property,
      'order': order,
      'from': from.toIso8601String(),
      'to': to?.toIso8601String(),
    };
  }
}
