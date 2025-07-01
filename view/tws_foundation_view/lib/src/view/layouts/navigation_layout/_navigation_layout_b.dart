part of 'navigation_layout.dart';

///
abstract class _NavigationLayoutB extends StatelessWidget {
  ///
  final Widget page;

  ///
  final Size pageSize;

  ///
  final Route? rootRoute;

  ///
  final RouteData routeData;

  ///
  final NavigationLayoutHeaderUserI? user;

  ///
  final List<NavigationLayoutEntryI> navigationEntries;

  ///
  const _NavigationLayoutB({
    this.user,
    this.rootRoute,
    required this.page,
    required this.pageSize,
    required this.routeData,
    required this.navigationEntries,
  });
}
