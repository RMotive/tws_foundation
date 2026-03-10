import 'package:csm_client_core/csm_client_core.dart';

/// {enum} for [IViewFilterNode.discriminator] values.
/// 
/// Defines the possible filter node/discriminator values for [IViewFilterNode] implementations.
enum ViewFilterDiscriminator { 
  ///
  viewLogicalFilter, // TODO changed to lowercase, check if it affects other implementations
  /// 
  viewPropertyFilter,
  ///  
  viewDateFilter,
}

/// {implementation} class for [EntityTableFilters]. 
/// Stores filtering configuration for an [EntityTable].
final class EntityTableFilters<TEntity extends EntityBase<TEntity>> implements IViewFilter<TEntity> {
  /// Collection of [ViewPropertyFilter] to apply the filter calculation based on the [operator].
  final List<ViewPropertyFilter<TEntity>> filters;

  /// Logical operator instruction to apply to this group of [filters].
  final ViewFilterLogicalOperators operator;

  @override
  String discriminator = ViewFilterDiscriminator.viewLogicalFilter.name;

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