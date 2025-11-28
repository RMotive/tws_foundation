part of '../navigation_layout.dart';

///
final class _NavigationLayoutNavigation extends StatelessWidget {
  ///
  final Route currentRoute;

  ///
  final List<NavigationLayoutEntryI> navigationEntries;

  ///
  final RouteData routeData;

  ///
  const _NavigationLayoutNavigation({required this.currentRoute, required this.navigationEntries, required this.routeData});

  @override
  Widget build(BuildContext context) {
    final FoundationThemeB theme  = Theming.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: <Widget>[
            for (NavigationLayoutEntryI entry in navigationEntries) ...<Widget>[
              _EntryButton(
                entry: entry,
                textColor: theme.navigationLayout.fore,
                onHoverBackgroundColor: theme.navigationLayout.fore,
                onHoverTextColor: theme.navigationLayout.back,
                backgroundColor: theme.navigationLayout.back,
                evaluateSelection: () => entry.route == routeData.route,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
