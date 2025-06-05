import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router, Route;
import 'package:tws_foundation_view/src/layouts/navigation_layout/_navigation_layout_header/navigation_layout_header_user.dart';
import 'package:tws_foundation_view/src/layouts/navigation_layout/_navigation_layout_navigation/navigation_layout_entry.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';

part '_navigation_layout_b.dart';
part '_navigation_layout_large,.dart';
part '_navigation_layout_small.dart';

part '_navigation_layout_header/_navigation_layout_header.dart';
part '_navigation_layout_header/_navigation_layout_header_user_button.dart';
part '_navigation_layout_header/_navigation_layout_header_user_button_menu.dart';

part '_navigation_layout_navigation/_navigation_layout_navigation.dart';
part '_navigation_layout_navigation/_navigation_layout_navigation_reactor.dart';

/// {LayoutNode} class.
///
/// Implements a [RouteLayout] node to simplify the routing tree subscription for [NavigationLayout] configurations.
final class NavigationLayoutNode extends RouteLayoutB {
  /// Home [Route] used to draw a direction header button to access it easier.
  final Route? rootRoute;

  /// Application themes available that will be handled by a Theme Switcher at the header.
  final List<ThemeI> appThemes;

  /// Solution specific user information builder to get and calculate user information to display at header user button.
  final NavigationLayoutHeaderUserI? Function()? userBuilder;

  /// The navigation entries to be handled, drawing navigation buttons and the routing behavior.
  final List<NavigationLayoutEntryI> navigationEntries;

  /// Creates a new [NavigationLayoutNode] instance.
  NavigationLayoutNode({
    this.rootRoute,
    this.userBuilder,
    required super.routes,
    this.appThemes = const <ThemeI>[],
    this.navigationEntries = const <NavigationLayoutEntryI>[],
  }) : super(
         layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
           return NavigationLayout(
             page: page,
             rootRoute: rootRoute,
             appThemes: appThemes,
             user: userBuilder?.call(),
             routeData: routeData,
             navigationEntries: navigationEntries,
           );
         },
       );
}

///
final class NavigationLayout extends LayoutB {
  ///
  final Route? rootRoute;

  ///
  final RouteData routeData;

  ///
  final List<ThemeI> appThemes;

  ///
  final NavigationLayoutHeaderUserI? user;

  final List<NavigationLayoutEntryI> navigationEntries;

  ///
  const NavigationLayout({
    this.user,
    this.rootRoute,
    required super.page,
    required this.routeData,
    this.appThemes = const <ThemeI>[],
    this.navigationEntries = const <NavigationLayoutEntryI>[],
  });

  ///
  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return ResponsiveWidget(
      onLarge: _NavigationLayoutLarge(
        page: page,
        user: user,
        pageSize: pageSize,
        rootRoute: rootRoute,
        routeData: routeData,
        appThemes: appThemes,
        navigationEntries: navigationEntries,
      ),
      onSmall: _MasterLayoutSmall(
        user: user,
        page: page,
        pageSize: pageSize,
        routeData: routeData,
        navigationEntries: navigationEntries,
      ),
    );
  }
}
