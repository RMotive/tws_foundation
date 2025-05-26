part of 'navigation_layout.dart';

///
abstract class _NavigationLayoutB extends StatelessWidget {
  ///
  final RouteData routeData;

  ///
  final Widget page;

  ///
  const _NavigationLayoutB({
    required this.routeData,
    required this.page,
  });
}
