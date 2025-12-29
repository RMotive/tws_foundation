import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/models/view_filters/view_filter_i.dart';

/// {implementation} class for [ViewFilterProperty].
///
///
/// [T] type of the [EntityI] implementation the filter will be applied to.
///
/// Defines an implementaiton from [ViewFilterI], represents a data filtering instruction for the {View} operation calculation
/// based on a [T] specific property.
final class ViewFilterProperty<T extends EntityI<T>> implements ViewFilterI<T> {
  @override
  String discriminator = '';

  @override
  int order = 0;

  /// Name of the [T] proeperty to be filtered.
  @override
  String property = '';

  /// Reference filtering value.
  Object? value;

  /// Filtering operator.
  ViewFilterOperators operator = ViewFilterOperators.equal;

  /// Creates a new [ViewFilterProperty] instance.
  ViewFilterProperty();


  /// Creates a new [ViewFilterProperty] instances with required properties for values filtering.
  ViewFilterProperty.a({
    required this.property,
    required this.operator,
    this.value,
  });

  @override
  DataMap encode() {
    return <String, dynamic>{
      EntityKeys.discriminator: discriminator,
      'order': order,
      'property': property,
      'evaluation': operator.index,
      'value': value?.toString(),
      'operator': operator.name
    };
  }
}

/// {enum} implementation for [ViewFilterOperators].
///
/// Defines the available operators that can be used for [ViewFilterProperty.operator] property.
enum ViewFilterOperators {
  /// Whether the [EntityI] property must be equal the [ViewFilterProperty.value].
  equal,

  /// Whether the [EntityI] property must contains the [ViewFilterProperty.value].
  contains,

  /// Whether the [EntityI] property must be less than the [ViewFilterProperty.value].
  lessThan,

  /// Whether the [EntityI] property must be equal or less than the [ViewFilterProperty.value].
  lessThanEqual,

  /// Whether the [EntityI] property must be greater than the [ViewFilterProperty.value].
  greaterThan,

  /// Whether the [EntityI] property must be equal or greater than the [ViewFilterProperty.value].
  greaterThanEqual,
}
