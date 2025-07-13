part of '../category_layout.dart';

/// Draws the [CategoryLayout] actions ribbons wich are two, one for the current resolved {Page} actions and another one ribbon
/// for inner [CategoryLayout.pages] navigation.
final class _CategoryLayoutRibbon extends StatelessWidget {
  /// Based on [LayoutB] route data calculation stores the current [Route] information
  final Route currentRoute;

  /// Category pages.
  final List<CategoryLayoutPageI> pages;

  /// [Key] reference for [_CategoryLayoutMessenger] to get its [State] and handle outside calls.
  final GlobalKey<CategoryLayoutMessengerState> messengerRef;

  /// Creates a new [_CategoryLayoutRibbon] instance.
  const _CategoryLayoutRibbon({
    required this.pages,
    required this.currentRoute,
    required this.messengerRef,
  });

  @override
  Widget build(BuildContext context) {
    final CategoryLayoutPageI currentEntry = pages.firstWhere(
      (CategoryLayoutPageI article) => article.route == currentRoute,
    );

    List<ActionsRibbonNodeI> actions = currentEntry.actions ?? <ActionsRibbonNodeI>[];

    return Visibility(
      visible: actions.isNotEmpty,
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          spacing: 8,
          children: <Widget>[
            /// --> {Page} actions.
            if (actions.isNotEmpty)
              Expanded(
                flex: 2,
                child: _CategoryLayoutRibbonWidget(
                  children: <Widget>[
                    for (ActionsRibbonNodeI action in actions) action.compose(messengerRef),
                  ],
                ),
              ),

            /// --> Category pages navigation.
            Expanded(
              child: _CategoryLayoutRibbonWidget(
                children: <Widget>[],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
final class _CategoryLayoutRibbonWidget extends StatelessWidget {
  /// Inner [Row.children] content.
  final List<Widget> children;

  const _CategoryLayoutRibbonWidget({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        constraints = constraints.boxed();
        Size sectionSize = constraints.biggest;

        return DecoratedBox(
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                width: 1,
                color: Colors.blueGrey,
              ),
            ),
          ),
          child: SizedBox(
            width: sectionSize.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  spacing: 4,
                  children: children,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
