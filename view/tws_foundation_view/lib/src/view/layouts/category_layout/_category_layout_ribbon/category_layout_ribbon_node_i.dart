part of '../category_layout.dart';

/// Defines a [CategoryLayout] ribbon action node, this to handle recursiveness drawing along
/// grouping, inner actions, and grouping actions customizations.
sealed class CategoryLayoutRibbonNodeI {
  /// Node title.
  final String title;

  /// Node description, usually displayed as a [Tooltip] at the action.
  final String description;

  /// Creates a new [CategoryLayoutRibbonNodeI] instance.
  const CategoryLayoutRibbonNodeI({
    required this.title,
    required this.description,
  });

  /// Composes the [CategoryLayoutRibbonNodeI] as a translated [Widget] at the [CategoryLayout] ribbon, drawing its implementation.
  Widget compose(BuildContext buildContext);
}
