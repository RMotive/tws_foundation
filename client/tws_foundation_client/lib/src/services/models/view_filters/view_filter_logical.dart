import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/models/view_filters/view_filter_i.dart';
import 'package:tws_foundation_client/src/services/models/view_filters/view_filter_node_i.dart';

/// {implementation} class for [ViewFilterLogical].
///
///
/// [T] type of the [EntityI] implementation the filter will be applied to.
///
/// Defines an implementation from a [ViewFilterNodeI] that represents a data filtering instruction
/// for a logical operator based on a collection of filters.
final class ViewFilterLogical<T extends EntityI<T>> implements ViewFilterNodeI<T> {
  @override
  String discriminator = '';

  @override
  int order = 0;

  /// Collection of [ViewFilterI] to apply the calculation based on the [operator].
  List<ViewFilterI<T>> filters = <ViewFilterI<T>>[];

  /// Logical operator instruction to apply to this group of [filters].
  ViewFilterLogicalOperators operator = ViewFilterLogicalOperators.or;

  /// Creates a new [ViewFilterLogical] instance.
  ViewFilterLogical(this.order, this.operator, this.filters);

  @override
  DataMap encode() {
    List<DataMap> filtersData = filters
        .map(
          (ViewFilterI<T> i) => i.encode(),
        )
        .toList();

    return <String, dynamic>{
      EntityKeys.discriminator: discriminator.toLowerCase(),
      'order': order,
      'operator': operator.index,
      'filters': filtersData,
    };
  }
}

/// {enum} implementation for [ViewFilterLogicalOperators].
///
/// Defines the available logical operators that can be used for [ViewFilterLogical.operator] property.
enum ViewFilterLogicalOperators {
  /// Whether the [ViewFilterLogical.filters] must be calculated with an [or] logical result calculation.
  or,

  /// Whether the [ViewFilterLogical.filters] must be calculated with an [and] logical result calculation.
  and,
}
