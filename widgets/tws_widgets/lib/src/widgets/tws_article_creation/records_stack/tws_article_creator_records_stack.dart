part of '../tws_article_creator.dart';
/// [_RecordsStack] Section to display the [TModel] item value based on [itemDesigner] method.
class _RecordsStack<TModel> extends StatelessWidget {
  /// State values for added items.
  final List<TWSArticleCreatorItemState<TModel>> states;
  /// theme colors scheme.
  final SimpleTheming pageTheme;
  /// Section width.
  final double creatorWidth;
  /// Custom item designer.
  final Widget Function(TModel actualModel, bool isSelected, bool invalid) itemDesigner;
  /// Selected item index.
  final int currentItemIndex;
  /// On change method selection method.
  final void Function(int index) changeItem;
  /// On remove selection method.
  final void Function(int currentItem) remove;
  /// On add new item.
  final void Function() add;

  const _RecordsStack({
    required this.pageTheme,
    required this.states,
    required this.creatorWidth,
    required this.itemDesigner,
    required this.currentItemIndex,
    required this.changeItem,
    required this.remove,
    required this.add,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManagerI<TWSFThemeBase>  themeManager =  Injector.getThemeManager<TWSFThemeBase>();
    SimpleTheming dangerTheme = themeManager.get().primaryCriticalControl;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        spacing: 12,
        children: <Widget>[
          // --> Actions
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
            
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Records: (${states.length})',
                    style: TextStyle(
                      color: pageTheme.fore,
                    ),
                  ),
                ),
                // --> Add item action
                PointerArea(
                  onClick: add,
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.add_circle,
                    size: 24,
                    color: pageTheme.fore,
                  ),
                ),
                // --> Remove selection
                PointerArea(
                  onClick: () => remove(currentItemIndex),
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.remove_circle,
                    size: 24,
                    color: dangerTheme.fore,
                  ),
                ),
              ],
            ),
          ),
          // --> Stack Display Content
          Expanded(
            child: LayoutBuilder(
              builder: (_, BoxConstraints constrains) {
                final ScrollController ctrl = ScrollController();
                WidgetsBinding.instance.addPostFrameCallback(
                  (Duration timestamp) {
                    ctrl.animateTo(0, duration: 300.miliseconds, curve: Curves.easeOut);
                  },
                );
      
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: constrains.maxHeight,
                  ),
                  child: ListView.builder(
                    itemCount: states.length,
                    controller: ctrl,
                    itemBuilder: (BuildContext context, int index) {
                      final bool currentActive = currentItemIndex == index;
      
                      return PointerArea(
                        cursor: currentActive ? MouseCursor.defer : SystemMouseCursors.click,
                        onClick: () => changeItem(index),
                        child: ReactiveWidget<TWSArticleCreatorItemState<TModel>>(
                          reactor: states[index],
                          builder: (BuildContext ctx, TWSArticleCreatorItemState<TModel> state) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 3,
                              ),
                              child: SizedBox(
                                width: creatorWidth,
                                child: itemDesigner(state.model, currentActive, state.valid),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
