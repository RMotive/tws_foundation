import 'package:csm_view/csm_view.dart';
import 'package:example/entries/auth_page.dart';
import 'package:example/entries/category_layout.dart';
import 'package:example/entries/entity_table.dart';
import 'package:example/entries/navigation_layout.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:example/themes/landing_theme_dark.dart';
import 'package:example/themes/landing_theme_light.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

void main() {
  runApp(const MainApp());
}

final class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LandingThemeB> themes = <LandingThemeB>[
      LandingThemeDark(),
      LandingThemeLight(),
    ];

    return PackageLanding<LandingThemeB>(
      name: "TWS Foundation View",
      description: (_, Color foreColor) {
        return TextSpan(
          text: 'This package provides a wide widget collection for UI implementations in TWS solutions.',
          style: TextStyle(color: foreColor, fontSize: 16),
        );
      },
      onInit: () {
        ThemeManagerI<LandingThemeB> themeInstance = Injector.getThemeManager();

        Injector.addSingleton<ThemeManagerI<view.FoundationThemeB>>(themeInstance);

        final FoundationServer foundationServer = FoundationServer(kReleaseMode);

        Injector.addSingleton<FoundationServer>(foundationServer);
        Injector.addSingleton<SecurityServiceI>(foundationServer.securityService);
        Injector.addSingleton<SolutionsServiceI>(foundationServer.solutionsService);
      },
      defaultTheme: LandingThemeDark(),
      themes: themes,
      landingEntries: <PackageLandingEntryI<LandingThemeB>>[
        AuthPage(),
        CategoryLayout(),
        EntityTable(),
        NavigationLayout(
          appThemes: themes,
        ),
      ],
    );
  }
}
