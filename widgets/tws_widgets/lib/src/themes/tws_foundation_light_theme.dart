import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/src/core/constants/foundation_colors.dart';
import 'package:tws_widgets/src/themes/tws_foundation_theme_base.dart';

class TWSFThemeLight extends TWSFThemeBase {
  static const String kIdentifier = 'foundation-light-flat-theme';
  const TWSFThemeLight()
    : super(
        kIdentifier,
        frame: TWSFColors.warmWhite,
        masterLayout: const CSMColorThemeOptions(
          TWSFColors.oceanBlue,
          TWSFColors.warmWhite,
          Colors.transparent,
        ),
        page: const CSMColorThemeOptions(
          TWSFColors.warmWhite,
          TWSFColors.lightDark,
          TWSFColors.oceanBlue,
          hightlightAlt: TWSFColors.warmWhite,
        ),
        primaryControlColor: const CSMColorThemeOptions(
          TWSFColors.oceanBlue,
          TWSFColors.lightDark,
          TWSFColors.oceanBlue,
          foreAlt:TWSFColors.warmWhite,
        ),
        primaryDisabledControl: const CSMColorThemeOptions(
          TWSFColors.darkGrey,
          TWSFColors.darkGrey,
          TWSFColors.darkGrey,
          foreAlt: TWSFColors.darkGrey,
        ),
        primaryCriticalControl: const CSMColorThemeOptions(
          Colors.transparent,
          Color.fromARGB(255, 208, 136, 130),
          TWSFColors.smoothWine,
          foreAlt: Color.fromARGB(255, 208, 136, 130),
        ),
        articlesLayoutSelectorButtonState: const CSMStateThemeOptions(
          main: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlue,
            foreground: TWSFColors.warmWhite,
          ),
          hoverStruct: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlueH,
          ),
          selectStruct: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlueH,
          ),
        ),
        masterLayoutMenuButtonState: const CSMStateThemeOptions(
          main: CSMGenericThemeOptions(
            background: Colors.transparent,
            foreground: TWSFColors.warmWhite,
            textStyle: TextStyle(fontSize: 14),
          ),
          hoverStruct: CSMGenericThemeOptions(background: Colors.white10),
          selectStruct: CSMGenericThemeOptions(
            background: Colors.white10,
            foreground: TWSFColors.warmWhite,
          ),
        ),
        articlesLayoutActionButtonState: const CSMStateThemeOptions(
          main: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlue,
            foreground: TWSFColors.warmWhite,
          ),
          hoverStruct: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlueH,
            foreground: Colors.white60,
          ),
          selectStruct: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlueH,
          ),
        ),
        primaryControlState: const CSMStateThemeOptions(
          main: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlue,
            foreground: TWSFColors.warmWhite,
          ),
          hoverStruct: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlueH,
          ),
          selectStruct: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlueH,
          ),
        ),
        criticalControlState: const CSMStateThemeOptions(
          main: CSMGenericThemeOptions(
            background: TWSFColors.smoothWine,
            foreground: TWSFColors.lightDark,
          ),
          hoverStruct: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlueH,
          ),
          selectStruct: CSMGenericThemeOptions(
            background: TWSFColors.oceanBlueH,
          ),
        ),
      );
}
