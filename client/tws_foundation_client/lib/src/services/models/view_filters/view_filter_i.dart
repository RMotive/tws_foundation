import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/models/view_filters/view_filter_node_i.dart';

/// {interface} for [ViewFilterI].
///
///
/// [T] type of the [EntityI] implementation that the filter is based on.
///
/// Defines a contract for [ViewFilterI] implementations that represents data filtering instructions
/// indicating the { View } generation how to build the result data.
abstract interface class ViewFilterI<T extends EntityI<T>> implements ViewFilterNodeI<T> {
  /// Name of the [T] proeperty to be filtered.
  final String property;

  /// Creates a new [ViewFilterI] instance.
  const ViewFilterI(this.property);
}
