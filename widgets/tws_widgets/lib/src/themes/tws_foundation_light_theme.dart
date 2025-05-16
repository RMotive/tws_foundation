import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/src/core/foundation_colors.dart';
import 'package:tws_widgets/src/themes/tws_foundation_theme_base.dart';

class TWSFThemeLight extends TWSFThemeBase {
  const TWSFThemeLight()
    : super(
        'foundation-light-flat-theme',
        iconBackground: TWSFColors.warmWhite,
        icon: const Icon(Icons.abc),
        masterLayout: const SimpleTheming(
          back: TWSFColors.oceanBlue,
          fore: TWSFColors.warmWhite,
          accent: Colors.transparent,
        ),
        page: const SimpleTheming(
          back: TWSFColors.warmWhite,
          fore: TWSFColors.lightDark,
          accent: TWSFColors.oceanBlue,
          foreAlt: TWSFColors.warmWhite,
        ),
        primaryControlColor: const SimpleTheming(
          back: TWSFColors.oceanBlue,
          fore: TWSFColors.lightDark,
          accent:TWSFColors.oceanBlue,
          foreAlt:TWSFColors.warmWhite,
        ),
        primaryDisabledControl: const SimpleTheming(
          back: TWSFColors.darkGrey,
          fore: TWSFColors.darkGrey,
          accent: TWSFColors.darkGrey,
          foreAlt: TWSFColors.darkGrey,
        ),
        primaryCriticalControl: const SimpleTheming(
          back: Colors.transparent,
          fore: Color.fromARGB(255, 208, 136, 130),
          accent: TWSFColors.smoothWine,
          foreAlt: Color.fromARGB(255, 208, 136, 130),
        ),
        articlesLayoutSelectorButtonState: const StateTheming(
          main: ComplexTheming(
            background: TWSFColors.oceanBlue,
            foreground: TWSFColors.warmWhite,
          ),
          hoverStruct: ComplexTheming(
            background: TWSFColors.oceanBlueH,
          ),
          selectStruct: ComplexTheming(
            background: TWSFColors.oceanBlueH,
          ),
        ),
        masterLayoutMenuButtonState: const StateTheming(
          main: ComplexTheming(
            background: Colors.transparent,
            foreground: TWSFColors.warmWhite,
            textStyle: TextStyle(fontSize: 14),
          ),
          hoverStruct: ComplexTheming(background: Colors.white10),
          selectStruct: ComplexTheming(
            background: Colors.white10,
            foreground: TWSFColors.warmWhite,
          ),
        ),
        articlesLayoutActionButtonState: const StateTheming(
          main: ComplexTheming(
            background: TWSFColors.oceanBlue,
            foreground: TWSFColors.warmWhite,
          ),
          hoverStruct: ComplexTheming(
            background: TWSFColors.oceanBlueH,
            foreground: Colors.white60,
          ),
          selectStruct: ComplexTheming(
            background: TWSFColors.oceanBlueH,
          ),
        ),
        primaryControlState: const StateTheming(
          main: ComplexTheming(
            background: TWSFColors.oceanBlue,
            foreground: TWSFColors.warmWhite,
          ),
          hoverStruct: ComplexTheming(
            background: TWSFColors.oceanBlueH,
          ),
          selectStruct: ComplexTheming(
            background: TWSFColors.oceanBlueH,
          ),
        ),
        criticalControlState: const StateTheming(
          main: ComplexTheming(
            background: TWSFColors.smoothWine,
            foreground: TWSFColors.lightDark,
          ),
          hoverStruct: ComplexTheming(
            background: TWSFColors.oceanBlueH,
          ),
          selectStruct: ComplexTheming(
            background: TWSFColors.oceanBlueH,
          ),
        ),
        pageTheming: const SimpleTheming(
          back: TWSFColors.warmWhite,
          fore: TWSFColors.oceanBlue,
          accent: TWSFColors.warmWhite,
        ),
        headerTheming: const SimpleTheming(
          back: TWSFColors.oceanBlue,
          fore: TWSFColors.lightDark,
          accent: TWSFColors.oceanBlue,
          foreAlt: TWSFColors.ligthGrey,
        ),
        welcomeCardTheming: const SimpleTheming(
          back: TWSFColors.oceanBlue,
          fore: TWSFColors.lightDark,
          accent:TWSFColors.oceanBlue,
          foreAlt:TWSFColors.warmWhite,
        ),
      );
}
