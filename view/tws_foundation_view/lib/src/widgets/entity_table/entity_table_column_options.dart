part of 'entity_table.dart';

/// {model} class.
///
/// Implements a data {model} class to store options to draw correctly an [EntityTable] column.
final class EntityTableColumnOptions<T> {
  /// Column title.
  final String title;

  /// Column fixed width, when set this value overrides the {minWidth} constraint built-in calculation for header and column content.
  final double? width;

  /// Column content factory, builds how at each entity row the column content value.
  final String Function(T entity, int index, BuildContext buildContext) factory;

  /// Creates a new [EntityTableColumnOptions] instance.
  const EntityTableColumnOptions({
    this.width,
    required this.title,
    required this.factory,
  });
}
