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
        page: const SimpleTheming(
          back: FoundationColors.lightDark,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
          foreAlt: FoundationColors.warmWhite,
          accentAlt: FoundationColors.warmWhite,
        ),
        error: const SimpleTheming(
          back: FoundationColors.lightDark,
          fore: Color.fromARGB(255, 255, 21, 0),
          accent: FoundationColors.deepWine,
          foreAlt: FoundationColors.warmWhite,
          accentAlt: FoundationColors.oceanBlue,
        ),
        warning: const SimpleTheming(
          back: FoundationColors.lightDark,
          fore: Color.fromARGB(255, 255, 21, 0),
          accent: Color.fromARGB(255, 245, 127, 23),
          foreAlt: FoundationColors.warmWhite,
          accentAlt: FoundationColors.oceanBlue,
        ),
        success: const SimpleTheming(
          back: FoundationColors.lightDark,
          fore: Colors.green,
          accent: Colors.green,
        ),
        disabled: const SimpleTheming(
          back: FoundationColors.darkGrey,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
        ),
        control: const SimpleTheming(
          back: FoundationColors.lightDark,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
        ),
        entityTable: const EntityTableTheming(
          drawerActionBackground: FoundationColors.warmWhite,
        ),
        navigationLayout: const SimpleTheming(
          back: FoundationColors.oceanBlue,
          fore: FoundationColors.warmWhite,
          accent: Colors.transparent,
        ),
        categoryLayoutRibbonButton: const StateTheming(
          main: ComplexTheming(
            background: FoundationColors.oceanBlue,
            foreground: FoundationColors.warmWhite,
          ),
          hoverStruct: ComplexTheming(background: FoundationColors.oceanBlueH),
          selectStruct: ComplexTheming(background: FoundationColors.oceanBlueH),
        ),
      );
}
