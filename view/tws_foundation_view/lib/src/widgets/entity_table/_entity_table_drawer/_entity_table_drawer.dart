part of '../entity_table.dart';

/// {widget} class.
///
/// [TEntity] type of the business entity to handle.
///
/// Draws a details animated drawer for [EntityTable] when an [TEntity] is selected.
final class _EntityTableDrawer<TEntity extends EntityB<TEntity>> extends StatelessWidget {
  /// Creates a new [_EntityTableDrawer] instance.
  const _EntityTableDrawer();

  @override
  Widget build(BuildContext context) {
    final _TWSArticleTableDetailsState state = _TWSArticleTableDetailsState();

    final ThemeManagerI<FoundationThemeB> themeManager = Injector.get();

    final SimpleTheming tPage = themeManager.get().page;

    return ColoredBox(
      color: tPage.back,
      child: TWSFrameDecoration(
        topPadding: 0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ReactiveWidget<_TWSArticleTableDetailsState>(
            reactor: state,
            builder: (BuildContext ctx, _TWSArticleTableDetailsState state) {
              return Column(
                children: <Widget>[
                  // --> Details section actions
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // --> Title
                      Expanded(
                        child: Text(
                          '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // --> Details custom content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: SizedBox(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
