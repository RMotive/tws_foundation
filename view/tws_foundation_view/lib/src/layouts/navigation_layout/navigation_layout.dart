import 'package:csm_view/csm_view.dart' show LayoutB, ResponsiveWidget, RouteData, SimpleTheming, Theming;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Widget, Size, BuildContext, StatelessWidget, Icons;
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';

part '_navigation_layout_b.dart';
part '_navigation_layout_header/_navigation_layout_header.dart';
part '_navigation_layout_large,.dart';
part '_navigation_layout_small.dart';

///
final class NavigationLayout extends LayoutB {
  ///
  final RouteData routeData;

  ///
  const NavigationLayout({
    required super.page,
    required this.routeData,
  });

  ///

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return ResponsiveWidget(
      onLarge: _MasterLayoutLarge(
        page: page,
        routeData: routeData,
      ),
      onSmall: _MasterLayoutSmall(
        page: page,
        routeData: routeData,
      ),
    );
  }
}
