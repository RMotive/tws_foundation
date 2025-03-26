part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsArticleTable = CSMPackageLandingEntry(
  name: "TWSArticleTable", 
  description: RichText(
    text: TextSpan(
      text:
          "Create a data grid table, with custom headers, content and interactable rows and drawer options.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    TWSFThemeBase theme = getTheme<TWSFThemeBase>();
    final TWSArticleTableAgent agent = TWSArticleTableAgent();
    return ColoredBox(
      color: theme.page.main,
      child: CSMSpacingColumn(
        spacing: 10,
        children: <Widget>[
          Expanded(
            child: TWSArticleTable<Feature>(
              size: 25,
              sizes: <int>[25, 50, 75, 100],
              adapter: const TableAdapter(),
              agent: agent,
              fields: <TWSArticleTableFieldOptions<Feature>>[
                TWSArticleTableFieldOptions<Feature>(
                  'Name',
                  (Feature item, int index, BuildContext ctx) => item.name,
                ),
                TWSArticleTableFieldOptions<Feature>(
                  'Description',
                  (Feature item, int index, BuildContext ctx) => item.description ?? "---",
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
);