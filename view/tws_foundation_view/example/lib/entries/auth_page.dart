import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

///
final class AuthPage extends PackageLandingEntryB<LandingThemeB> {
  ///
  AuthPage({super.key})
    : super(
        name: 'Auth Page',
        description: (LandingThemeB theme, Color foreColor) {
          return TextSpan(
            text:
                'Page to authenticate users along all TWS Solutions by the configured authentication options.',
          );
        },
      );

  @override
  Widget composeEntry(
    BuildContext buildContext,
    Size windowSize,
    PackageLandingThemeB theme,
  ) {
    return view.AuthPage();
  }
}
