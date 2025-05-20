import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/core/constants.dart';
import 'package:tws_foundation_view/src/themes/twsf_theme_b.dart';

class TWSFDarkTheme extends TWSFThemeB {
  const TWSFDarkTheme()
    : super(
        'foundation-dark-flat-theme',
        iconBackground: TWSColors.warmWhite,
        icon: const Icon(Icons.abc),
        masterLayout: const SimpleTheming(back: TWSColors.oceanBlue, fore: TWSColors.warmWhite, accent: Colors.transparent),
        page: const SimpleTheming(back: TWSColors.lightDark, fore: TWSColors.warmWhite, accent: TWSColors.oceanBlue, foreAlt: TWSColors.darkGrey, accentAlt: TWSColors.warmWhite),
        primaryControlColor: const SimpleTheming(back: TWSColors.oceanBlue, fore: TWSColors.warmWhite, accent: TWSColors.oceanBlue),
        primaryDisabledControl: const SimpleTheming(back: TWSColors.darkGrey, fore: TWSColors.darkGrey, accent: TWSColors.darkGrey, foreAlt: TWSColors.warmWhite),
        primaryCriticalControl: const SimpleTheming(
          back: Colors.transparent,
          fore: Color.fromARGB(255, 208, 136, 130),
          accent: TWSColors.smoothWine,
          foreAlt: Colors.white,
          accentAlt: Color.fromARGB(255, 86, 151, 89),
        ),
        articlesLayoutSelectorButtonState: const StateTheming(
          main: ComplexTheming(background: TWSColors.oceanBlue, foreground: TWSColors.warmWhite),
          hoverStruct: ComplexTheming(background: TWSColors.oceanBlueH),
          selectStruct: ComplexTheming(background: TWSColors.oceanBlueH),
        ),
        masterLayoutMenuButtonState: const StateTheming(
          main: ComplexTheming(background: Colors.transparent, foreground: TWSColors.warmWhite, textStyle: TextStyle(fontSize: 14)),
          hoverStruct: ComplexTheming(background: Colors.white10),
          selectStruct: ComplexTheming(background: Colors.white10, foreground: TWSColors.warmWhite),
        ),
        articlesLayoutActionButtonState: const StateTheming(
          main: ComplexTheming(background: TWSColors.oceanBlue, foreground: TWSColors.warmWhite),
          hoverStruct: ComplexTheming(background: TWSColors.oceanBlueH, foreground: Colors.white60),
          selectStruct: ComplexTheming(background: TWSColors.oceanBlueH),
        ),
        primaryControlState: const StateTheming(
          main: ComplexTheming(background: TWSColors.oceanBlue, foreground: TWSColors.warmWhite),
          hoverStruct: ComplexTheming(background: TWSColors.oceanBlueH),
          selectStruct: ComplexTheming(background: TWSColors.oceanBlueH),
        ),
        criticalControlState: const StateTheming(
          main: ComplexTheming(background: TWSColors.deepWine, foreground: TWSColors.warmWhite),
          hoverStruct: ComplexTheming(background: TWSColors.oceanBlueH),
          selectStruct: ComplexTheming(background: TWSColors.oceanBlueH),
        ),
      );
}
