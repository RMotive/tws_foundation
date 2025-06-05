part of '../tws_article_table.dart';

class _TWSArticleTableDetailsAction extends StatelessWidget {
  final String? hint;
  final VoidCallback action;
  final IconData icon;
  final Color? fore;

  const _TWSArticleTableDetailsAction({
    this.hint,
    this.fore,
    required this.icon,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManagerI<FoundationThemeB> themeManager = Injector.get();
    final SimpleTheming tPage = themeManager.get().page;
    final SimpleTheming tPrimary = themeManager.get().primaryControlColor;
    return Tooltip(
      message: hint,
      child: PointerArea(
        cursor: SystemMouseCursors.click,
        onClick: action,
        child: DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, color: tPage.fore),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Icon(
              icon,
              color: fore ?? tPrimary.foreAlt ?? tPrimary.back,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
