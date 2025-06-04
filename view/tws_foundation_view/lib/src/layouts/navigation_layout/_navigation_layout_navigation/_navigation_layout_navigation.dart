part of '../navigation_layout.dart';

///
final class _NavigationLayoutNavigation extends StatelessWidget {
  ///
  final Route currentRoute;

  ///
  final List<NavigationLayoutEntryI> navigationEntries;

  ///
  const _NavigationLayoutNavigation({required this.currentRoute, required this.navigationEntries});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: <Widget>[
            for (NavigationLayoutEntryI entry in navigationEntries) ...<Widget>[
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 5,
                ),
                child: SizedBox(
                  child: Center(
                    child: Text(
                      entry.title,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
