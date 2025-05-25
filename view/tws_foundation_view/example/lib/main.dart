import 'package:csm_view/csm_view.dart';
import 'package:example/entries/auth_page.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:example/themes/landing_theme_dark.dart';
import 'package:example/themes/landing_theme_light.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart' hide AuthPage;

void main() {
  runApp(const MainApp());
}

final class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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

        Injector.addSingleton<ThemeManagerI<FoundationThemeB>>(themeInstance);

        final FoundationServer foundationServer = FoundationServer();

        Injector.addSingleton<FoundationServer>(foundationServer);
        Injector.addSingleton<SecurityServiceI>(foundationServer.securityService);
      },
      defaultTheme: LandingThemeDark(),
      themes: <LandingThemeB>[LandingThemeDark(), LandingThemeLight()],
      landingEntries: <PackageLandingEntryI<LandingThemeB>>[AuthPage()],
    );
  }
}
