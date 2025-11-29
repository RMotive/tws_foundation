import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

class FoundationThemeLight extends FoundationThemeB {
  const FoundationThemeLight()
    : super(
        'foundation-light-flat-theme',
        entityTable: const EntityTableTheming(
          drawerActionBackground: FoundationColors.warmWhite,
        ),
        businessLogo: FoundationAssets.fullLogoWhiteWebp,
        iconBackground: FoundationColors.warmWhite,
        icon: const Icon(Icons.abc),
        navigationLayout: const SimpleTheming(
          back: FoundationColors.oceanBlue,
          fore: FoundationColors.warmWhite,
          accent: Colors.transparent,
        ),
        page: const SimpleTheming(
          back: FoundationColors.warmWhite,
          fore: FoundationColors.lightDark,
          accent: FoundationColors.oceanBlue,
          foreAlt: FoundationColors.warmWhite,
        ),
        error: const SimpleTheming(
          back: FoundationColors.warmWhite,
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
          fore: Color.fromARGB(255, 0, 117, 4),
          accent: Color.fromARGB(255, 0, 117, 4),
        ),
        control: const SimpleTheming(
          back: FoundationColors.warmWhite,
          fore: FoundationColors.lightDark,
          accent: FoundationColors.oceanBlue,
          foreAlt: FoundationColors.warmWhite,
        ),
        disabled: const SimpleTheming(
          back: FoundationColors.ligthGrey,
          fore: FoundationColors.warmWhite,
          accent: FoundationColors.oceanBlue,
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
