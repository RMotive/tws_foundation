part of '../tws_article_table.dart';

final class _TWSArticleTableHeader<TArticle> extends StatelessWidget {
  final List<TWSArticleTableFieldOptions<TArticle>> fields;
  final double minFieldWidth;
  final double fieldWidth;

  const _TWSArticleTableHeader({
    required this.fields,
    required this.fieldWidth,
    required this.minFieldWidth,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManager<TWSFThemeBase> themeManager = Injector.get();

    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            width: 1,
            color: Colors.blueGrey,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          for (int cont = 0; cont < fields.length; cont++)
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: fields[cont].width ?? minFieldWidth,
              ),
              child: SizedBox(
                width: fields[cont].width ?? fieldWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  child: Text(
                    fields[cont].name,
                    style: TextStyle(
                      color: themeManager.get().page.fore,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
