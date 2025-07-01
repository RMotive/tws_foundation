part of '../category_layout.dart';

/// Defines the data contract to correctly draw and handle a [CategoryLayout] ribbon action button.
abstract interface class CategoryLayoutRibbonActionOptionsI extends CategoryLayoutRibbonNodeI {
  /// Callback execution when action is invoked(clicked).
  final FutureOr<void> Function() onInvoke;

  /// Action icon builder.
  ///
  /// [recommended] based on the {theming} instance will pass the recommended foreground color
  /// for the [icon] built.
  final Widget Function(Color recommended) iconBuilder;

  /// Creates a new [CategoryLayoutRibbonActionOptionsI] instance.
  const CategoryLayoutRibbonActionOptionsI({
    required super.title,
    required super.description,
    required this.onInvoke,
    required this.iconBuilder,
  });
}

/// {model} class.
///
/// Defines a data {model} class to specify how a [CategoryLayout] ribbon action will be drawn
/// and handled.
final class CategoryLayoutRibbonActionOptions extends CategoryLayoutRibbonActionOptionsI {
  /// Creates a new [CategoryLayoutRibbonActionOptions] instance.
  const CategoryLayoutRibbonActionOptions({
    required super.title,
    required super.description,
    required super.onInvoke,
    required super.iconBuilder,
  });

  @override
  Widget compose(BuildContext buildContext) {
    return _CategoryLayoutRibbonActionButton(
      options: this,
    );
  }
}
