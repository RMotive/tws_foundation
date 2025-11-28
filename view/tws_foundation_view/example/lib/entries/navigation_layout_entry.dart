import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

///
final class NavigationLayoutEntry extends PackageLandingEntryB<LandingThemeB> {
  ///
  final List<ThemeDataI> appThemes;

  /// Creates a new [NavigationLayoutEntry] instance.
  NavigationLayoutEntry({
    super.key,
    required this.appThemes,
  }) : super(
         name: 'Navigation Layout',
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan();
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return view.NavigationLayout(
      user: view.NavigationLayoutHeaderUser(
        name: 'Package',
        email: 'package_landing@csm.com',
        lastName: 'Landing',
      ),
      routeData: RouteData(
        route: Route(''),
        absolutePath: '',
      ),
      rootRoute: Route('showcase_root'),
      page: SizedBox(),
      navigationEntries: <view.NavigationLayoutEntry>[
        view.NavigationLayoutEntry(
          title: 'Business',
          route: Route(''),
          icon:Icons.business,
        ),
        view.NavigationLayoutEntry(
          title: 'Security',
          route: Route(''),
          icon: Icons.security,
        )
      ],
    );
  }
}
