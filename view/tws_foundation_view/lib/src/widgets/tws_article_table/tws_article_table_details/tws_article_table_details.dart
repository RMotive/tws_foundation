part of '../tws_article_table.dart';

final class _TWSArticleTableDetails<TArticle extends EntityB<TArticle>> extends StatelessWidget {
  final TWSArticleTableAdapter<TArticle> adapter;
  final VoidCallback closeAction;
  final TArticle record;
  final String viewerTitle;
  final bool editable;
  final bool removable;


  const _TWSArticleTableDetails({
    required this.closeAction,
    required this.adapter,
    required this.record,
    required this.editable,
    required this.removable,
    required this.viewerTitle
  });

  void _closeDetails(_TWSArticleTableDetailsState state) {
    state.editing = false;
  }

  @override
  Widget build(BuildContext context) {
    final _TWSArticleTableDetailsState state = _TWSArticleTableDetailsState();

    final ThemeManagerI<TWSFThemeB> themeManager = Injector.get();

    final SimpleTheming tPage = themeManager.get().page;
    final StateTheming tCritical = themeManager.get().criticalControlState;

    return ColoredBox(
      color: tPage.back,
      child: TWSFrameDecoration(
        topPadding: 0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ReactiveWidget<_TWSArticleTableDetailsState>(
            reactor: state,
            builder: (BuildContext ctx, _TWSArticleTableDetailsState state) {
              final Widget? editionForm = adapter.composeEditor(record, () => _closeDetails(state), context);
              if (state._editing && editionForm != null) {
                return editionForm;
              }

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
                          viewerTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.italic
                          ),  
                        )
                      ),
                      // --> Close details action
                      _TWSArticleTableDetailsAction(
                        hint: 'Close record details',
                        icon: Icons.close,
                        action: closeAction,
                      ),
                      // --> Remove action.
                      if(removable)
                      _TWSArticleTableDetailsAction(
                        hint: 'Remove record',
                        icon: Icons.remove,
                        fore: tCritical.main.background,
                        action: () => adapter.onRemoveRequest(record, context),
                      ),
                      if(editable)
                      if(editionForm != null)
                        _TWSArticleTableDetailsAction(
                          hint: 'Edit record',
                          icon: Icons.edit,
                          action: () {
                            state.editing = true;
                          },
                        ),
                    ],
                  ),
                  // --> Details custom content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                      ),
                      child: adapter.composeViewer(record, context),
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
