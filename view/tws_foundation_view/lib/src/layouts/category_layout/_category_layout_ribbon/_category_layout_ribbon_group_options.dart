part of '../category_layout.dart';

/// Defines the data contract to correctly draw and handle a [CategoryLayout] ribbon action button.
abstract interface class CategoryLayoutRibbonGroupOptionsI extends CategoryLayoutRibbonNodeI {
  /// Group action options.
  final List<CategoryLayoutRibbonActionOptionsI> actions;

  /// Creates a new [CategoryLayoutRibbonGroupOptionsI] instance.
  const CategoryLayoutRibbonGroupOptionsI({
    required super.title,
    required super.description,
    required this.actions,
  });
}

/// {model} class.
///
/// Defines a data {model} class to specify how a [CategoryLayout] ribbon action will be drawn
/// and handled.
final class CategoryLayoutRibbonGroupOptions extends CategoryLayoutRibbonGroupOptionsI {
  /// Creates a new [CategoryLayoutRibbonGroupOptions] instance.
  const CategoryLayoutRibbonGroupOptions({
    required super.title,
    required super.description,
    required super.actions,
  });

  @override
  Widget compose(BuildContext buildContext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: LayoutBuilder(
            builder: (_, BoxConstraints constrains) {
              BoxConstraints actionBounds = constrains;
              if (!constrains.hasBoundedHeight) {
                actionBounds = constrains.tighten(
                  height: constrains.minHeight,
                );
              }

              return SizedBox(
                height: actionBounds.maxHeight - 4,
                child: Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (CategoryLayoutRibbonActionOptionsI action in actions)
                      _CategoryLayoutRibbonActionButton(
                        options: action,
                      ),
                  ],
                ),
              );
            },
          ),
        ),

        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
