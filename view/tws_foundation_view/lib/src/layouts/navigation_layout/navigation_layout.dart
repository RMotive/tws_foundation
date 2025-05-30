import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router, Route;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';

part '_navigation_layout_b.dart';
part '_navigation_layout_large,.dart';
part '_navigation_layout_small.dart';

part '_navigation_layout_header/_navigation_layout_header.dart';
part '_navigation_layout_header/_navigation_layout_header_user_button.dart';
part '_navigation_layout_header/_navigation_layout_header_user_button_menu.dart';

///
final class NavigationLayout extends LayoutB {
  ///
  final RouteData routeData;

  /// 
  final Route? rootRoute;

  ///
  final List<ThemeI> appThemes;

  ///
  const NavigationLayout({
    required super.page,
    required this.routeData,
    this.rootRoute,
    this.appThemes = const <ThemeI>[],
  });

  ///
  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return ResponsiveWidget(
      onLarge: _MasterLayoutLarge(
        page: page,
        rootRoute: rootRoute,
        routeData: routeData,
        appThemes: appThemes,
      ),
      onSmall: _MasterLayoutSmall(
        page: page,
        routeData: routeData,
      ),
    );
  }
}
