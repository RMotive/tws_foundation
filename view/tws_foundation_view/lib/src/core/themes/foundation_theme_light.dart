import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

class FoundationThemeLight extends FoundationThemeB {
  const FoundationThemeLight()
    : super(
        'foundation-light-flat-theme',
        businessLogo: FoundationAssets.fullLogoWhiteWebp,
        iconBackground: FoundationColors.warmWhite,
        icon: const Icon(Icons.abc),
        navigationLayout: const ThemingData(
          back: FoundationColors.oceanBlue,
          fore: FoundationColors.warmWhite,
          accent: Colors.transparent,
        ),
        page: const ThemingData(
          back: FoundationColors.warmWhite,
          fore: FoundationColors.lightDark,
          accent: FoundationColors.oceanBlue,
          foreAlt: FoundationColors.warmWhite,
        ),
        controlError: const ThemingData(
          back: FoundationColors.warmWhite,
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
          fore: Color.fromARGB(255, 0, 117, 4),
          accent: Color.fromARGB(255, 0, 117, 4),
        ),
        control: const ThemingData(
          back: FoundationColors.warmWhite,
          fore: FoundationColors.lightDark,
          accent: FoundationColors.oceanBlue,
          foreAlt: FoundationColors.warmWhite,
        ),
        controlDisabled: const ThemingData(
          back: FoundationColors.ligthGrey,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
        ),
        dialog: const ThemingData(
          back: FoundationColors.warmWhite,
          fore: FoundationColors.lightDark,
          accent: FoundationColors.oceanBlue,
          foreAlt: FoundationColors.warmWhite,
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
