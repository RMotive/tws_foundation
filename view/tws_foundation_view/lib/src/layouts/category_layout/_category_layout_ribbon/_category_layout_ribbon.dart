part of '../category_layout.dart';

///
final class _CategoryLayoutRibbon extends StatelessWidget {
  /// Based on [LayoutB] route data calculation stores the current [Route] information
  final Route currentRoute;

  /// Article entries.
  final List<CategoryLayoutEntryI> articles;

  /// Creates a new [_CategoryLayoutRibbon] instance.
  const _CategoryLayoutRibbon({
    required this.articles,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final CategoryLayoutEntryI currentEntry = articles.firstWhere(
      (CategoryLayoutEntryI article) => article.route == currentRoute,
    );

    final CategoryLayoutRibbonControllerI? ribbonController = currentEntry.ribbonController;

    return Visibility(
      child: SizedBox(
        height: 75,
        width: double.maxFinite,
        child: Row(
          spacing: 8,
          children: <Widget>[
            if (ribbonController?.validate() ?? false)
              Expanded(
                flex: 2,
                child: _CategoryLayoutRibbonSection(
                  children: <Widget>[
                    
                    // --> Refresh action button.
                    if (ribbonController?.onRefresh != null)
                      CategoryLayoutRibbonActionOptions(
                        title: 'Refresh',
                        description: 'Refreshes the current page',
                        onInvoke: ribbonController!.onRefresh!,
                        iconBuilder: (Color recommended) {
                          return Icon(
                            Icons.refresh_rounded,
                            color: recommended,
                          );
                        },
                      ).compose(context),

                    // --> Data Management action group.
                    if (ribbonController?.dataManagementController != null)
                      CategoryLayoutRibbonGroupOptions(
                        title: 'Data Management',
                        description: 'Data handling related actions',
                        actions: <CategoryLayoutRibbonActionOptionsI>[
                          // --> Create action
                          if (ribbonController?.dataManagementController?.onCreate != null)
                            CategoryLayoutRibbonActionOptions(
                              title: 'Create',
                              description: 'Create new entities',
                              onInvoke: ribbonController!.dataManagementController!.onCreate!,
                              iconBuilder: (Color recommended) {
                                return Icon(
                                  Icons.add_box_outlined,
                                  color: recommended,
                                );
                              },
                            ),

                          // --> Edit action
                          if (ribbonController?.dataManagementController?.onEdit != null)
                            CategoryLayoutRibbonActionOptions(
                              title: 'Edit',
                              description: 'Edit entities',
                              onInvoke: ribbonController!.dataManagementController!.onEdit!,
                              iconBuilder: (Color recommended) {
                                return Icon(
                                  Icons.edit_outlined,
                                  color: recommended,
                                );
                              },
                            ),

                          // --> Remove action
                          if (ribbonController?.dataManagementController?.onRemove != null)
                            CategoryLayoutRibbonActionOptions(
                              title: 'Remove',
                              description: 'Remove entities',
                              onInvoke: ribbonController!.dataManagementController!.onRemove!,
                              iconBuilder: (Color recommended) {
                                return Icon(
                                  Icons.remove_circle_outline_rounded,
                                  color: recommended,
                                );
                              },
                            ),
                        ],
                      ).compose(context),
                  ],
                ),
              ),

            Expanded(
              child: _CategoryLayoutRibbonSection(
                children: <Widget>[
                  for (CategoryLayoutEntryI article in articles)
                    _CategoryLayoutRibbonArticleButton(
                      isCurrent: currentEntry == article,
                      articleEntry: article,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
