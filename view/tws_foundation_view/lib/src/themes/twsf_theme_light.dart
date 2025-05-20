import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/core/constants.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

class TWSFThemeLight extends TWSFThemeB {
  const TWSFThemeLight()
    : super(
        'foundation-light-flat-theme',
        iconBackground: TWSColors.warmWhite,
        icon: const Icon(Icons.abc),
        masterLayout: const SimpleTheming(back: TWSColors.oceanBlue, fore: TWSColors.warmWhite, accent: Colors.transparent),
        page: const SimpleTheming(back: TWSColors.warmWhite, fore: TWSColors.lightDark, accent: TWSColors.oceanBlue, foreAlt: TWSColors.warmWhite),
        primaryControlColor: const SimpleTheming(back: TWSColors.oceanBlue, fore: TWSColors.lightDark, accent: TWSColors.oceanBlue, foreAlt: TWSColors.warmWhite),
        primaryDisabledControl: const SimpleTheming(back: TWSColors.darkGrey, fore: TWSColors.darkGrey, accent: TWSColors.darkGrey, foreAlt: TWSColors.darkGrey),
        primaryCriticalControl: const SimpleTheming(back: Colors.transparent, fore: Color.fromARGB(255, 208, 136, 130), accent: TWSColors.smoothWine, foreAlt: Color.fromARGB(255, 208, 136, 130)),
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
          main: ComplexTheming(background: TWSColors.smoothWine, foreground: TWSColors.lightDark),
          hoverStruct: ComplexTheming(background: TWSColors.oceanBlueH),
          selectStruct: ComplexTheming(background: TWSColors.oceanBlueH),
        ),
      );
}
