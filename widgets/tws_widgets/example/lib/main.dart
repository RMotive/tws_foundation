import 'package:csm_view/csm_view.dart';
import 'package:example/core/landing_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

void main() {
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CSMApplication<TWSFThemeBase>(
      defaultTheme: TWSFThemeLight(),
      themes: <TWSFThemeBase>[
        TWSFDarkTheme(),
        TWSFThemeLight(),
      ],
      home: LandingView()
    );
  }
}