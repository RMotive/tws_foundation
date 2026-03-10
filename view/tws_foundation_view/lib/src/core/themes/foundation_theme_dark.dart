import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

class FoundationThemeDark extends FoundationThemeB {
  const FoundationThemeDark()
    : super(
        'foundation-dark-flat-theme',
        icon: const Icon(Icons.abc),
        iconBackground: FoundationColors.warmWhite,
        businessLogo: FoundationAssets.fullLogoWhiteWebp,
        page: const ThemingData(
          back: FoundationColors.lightDark,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
          foreAlt: FoundationColors.warmWhite,
          accentAlt: FoundationColors.warmWhite,
        ),
        controlError: const ThemingData(
          back: FoundationColors.lightDark,
          fore: Color.fromARGB(255, 255, 21, 0),
          accent: FoundationColors.deepWine,
          foreAlt: FoundationColors.warmWhite,
          accentAlt: FoundationColors.oceanBlue,
        ),
        controlWarning: const ThemingData(
          back: FoundationColors.lightDark,
          fore: Color.fromARGB(255, 255, 21, 0),
          accent: Color.fromARGB(255, 245, 127, 23),
          foreAlt: FoundationColors.warmWhite,
          accentAlt: FoundationColors.oceanBlue,
        ),
        controlSuccess: const ThemingData(
          back: FoundationColors.lightDark,
          fore: Colors.green,
          accent: Colors.green,
        ),
        controlDisabled: const ThemingData(
          back: FoundationColors.darkGrey,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
        ),
        control: const ThemingData(
          back: FoundationColors.lightDark,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
        ),
        navigationLayout: const ThemingData(
          back: FoundationColors.oceanBlue,
          fore: FoundationColors.warmWhite,
          accent: Colors.transparent,
        ),
        dialog: const ThemingData(
          back: FoundationColors.lightDark,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
        ),
        categoryLayoutRibbonButton: const StateControlTheming(
          main: InputControlTheming(
            background: FoundationColors.oceanBlue,
            foreground: FoundationColors.warmWhite,
          ),
          hoverStruct: InputControlTheming(background: FoundationColors.oceanBlueH),
          selectStruct: InputControlTheming(background: FoundationColors.oceanBlueH),
        ),
      );
}
