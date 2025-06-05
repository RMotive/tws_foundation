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
                    if (ribbonController?.onRefresh != null)
                      _CategoryLayoutRibbonActionButton(
                        options: CategoryLayoutRibbonActionOptions(
                          title: '',
                          description: '',
                          onInvoke: () {},
                          iconBuilder: (Color recommended) {},
                        ),
                      ),
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
