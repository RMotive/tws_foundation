import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/core/constants.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';

class FoundationThemeDark extends FoundationThemeB {
  const FoundationThemeDark()
    : super(
        'foundation-dark-flat-theme',
        businessLogo: FoundationAssets.fullLogoWhiteWebp,
        iconBackground: FoundationColors.warmWhite,
        icon: const Icon(Icons.abc),
        navigationLayout: const SimpleTheming(
          back: FoundationColors.oceanBlue,
          fore: FoundationColors.warmWhite,
          accent: Colors.transparent,
        ),
        page: const SimpleTheming(
          back: FoundationColors.lightDark,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
          foreAlt: FoundationColors.darkGrey,
          accentAlt: FoundationColors.warmWhite,
        ),
        primaryControlColor: const SimpleTheming(
          back: FoundationColors.oceanBlue,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
        ),
        primaryDisabledControl: const SimpleTheming(
          back: FoundationColors.darkGrey,
          fore: FoundationColors.darkGrey,
          accent: FoundationColors.darkGrey,
          foreAlt: FoundationColors.warmWhite,
        ),
        primaryCriticalControl: const SimpleTheming(
          back: Colors.transparent,
          fore: Color.fromARGB(255, 208, 136, 130),
          accent: FoundationColors.smoothWine,
          foreAlt: Colors.white,
          accentAlt: Color.fromARGB(255, 86, 151, 89),
        ),
        articlesLayoutSelectorButtonState: const StateTheming(
          main: ComplexTheming(
            background: FoundationColors.oceanBlue,
            foreground: FoundationColors.warmWhite,
          ),
          hoverStruct: ComplexTheming(background: FoundationColors.oceanBlueH),
          selectStruct: ComplexTheming(background: FoundationColors.oceanBlueH),
        ),
        masterLayoutMenuButtonState: const StateTheming(
          main: ComplexTheming(
            background: Colors.transparent,
            foreground: FoundationColors.warmWhite,
            textStyle: TextStyle(fontSize: 14),
          ),
          hoverStruct: ComplexTheming(background: Colors.white10),
          selectStruct: ComplexTheming(
            background: Colors.white10,
            foreground: FoundationColors.warmWhite,
          ),
        ),
        articlesLayoutActionButtonState: const StateTheming(
          main: ComplexTheming(
            background: FoundationColors.oceanBlue,
            foreground: FoundationColors.warmWhite,
          ),
          hoverStruct: ComplexTheming(
            background: FoundationColors.oceanBlueH,
            foreground: Colors.white60,
          ),
          selectStruct: ComplexTheming(background: FoundationColors.oceanBlueH),
        ),
        primaryControlState: const StateTheming(
          main: ComplexTheming(
            background: FoundationColors.oceanBlue,
            foreground: FoundationColors.warmWhite,
          ),
          hoverStruct: ComplexTheming(background: FoundationColors.oceanBlueH),
          selectStruct: ComplexTheming(background: FoundationColors.oceanBlueH),
        ),
        criticalControlState: const StateTheming(
          main: ComplexTheming(
            background: FoundationColors.deepWine,
            foreground: FoundationColors.warmWhite,
          ),
          hoverStruct: ComplexTheming(background: FoundationColors.oceanBlueH),
          selectStruct: ComplexTheming(background: FoundationColors.oceanBlueH),
        ),
      );
}
