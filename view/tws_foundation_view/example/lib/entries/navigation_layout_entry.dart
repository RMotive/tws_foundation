import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

///
  final class NavigationLayoutEntry extends PackageLandingEntryBase<LandingThemeB> {
    ///
  final List<IThemeData> appThemes;

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
    final view.FoundationThemeB theme = ThemingUtils.get(buildContext);
    return NavigationLayout(
      appLogo: AssetImage(theme.businessLogo),
      userData: NavigationLayoutHeaderUserData(
        name: 'Package',
        email: 'package_landing@csm.com',
        lastName: 'Landing',
      ),
      routingData: RoutingData(
        targetRoute: RouteData(''),
        absolutePath: '',
      ),
      homeRouteData: RouteData('showcase_root'),
      page: SizedBox(),
      navigationNodes: <NavigationLayoutNode>[
        NavigationLayoutNode(
          title: 'Business',
          routeData: RouteData(''),
          icon:Icons.business,
        ),
        NavigationLayoutNode(
          title: 'Security',
          routeData: RouteData(''),
          icon: Icons.security,
        )
      ],
    );
  }
}
