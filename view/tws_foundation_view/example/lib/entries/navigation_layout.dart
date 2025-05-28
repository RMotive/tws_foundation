import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

///
final class NavigationLayout extends PackageLandingEntryB<LandingThemeB> {
  ///
  final List<ThemeI> appThemes;

  /// Creates a new [NavigationLayout] instance.
  NavigationLayout({
    super.key,
    required this.appThemes,
  }) : super(
         name: 'Navigation Layout',
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan();
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, PackageLandingThemeB theme) {
    return view.NavigationLayout(
      appThemes: appThemes,
      routeData: RouteData(
        route: Route(''),
        absolutePath: '',
      ),
      rootRoute: Route('showcase_root'),
      page: SizedBox(),
    );
  }
}
