import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {implementation} class for [EntityTableFilters]. 
/// Stores filtering configuration for an [EntityTable].
final class EntityTableFilters<TEntity extends EntityB<TEntity>> implements ViewFilterI<TEntity> {
  /// Collection of [ViewFilterProperty] to apply the filter calculation based on the [operator].
  final List<ViewFilterProperty<TEntity>> filters;

  /// Logical operator instruction to apply to this group of [filters].
  final ViewFilterLogicalOperators operator;

  @override
  String discriminator = ViewFilterDiscriminator.viewFilterLogical.name;

  @override
  String property = '';

  @override
  int order = 0;

  EntityTableFilters({
    required this.filters,
    required this.discriminator,
    this.operator = ViewFilterLogicalOperators.or,
  });
  
  @override
  DataMap encode() {
    throw UnimplementedError();
  }
}