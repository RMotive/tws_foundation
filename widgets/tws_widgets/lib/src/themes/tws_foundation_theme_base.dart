import 'package:csm_view/csm_view.dart';

abstract class TWSFThemeBase extends ThemeB{
  final SimpleTheming page;
  final SimpleTheming masterLayout;
  final SimpleTheming primaryControlColor;
  final SimpleTheming primaryDisabledControl;
  final SimpleTheming primaryCriticalControl;
  final StateTheming masterLayoutMenuButtonState;
  final StateTheming articlesLayoutActionButtonState;
  final StateTheming articlesLayoutSelectorButtonState;
  final StateTheming primaryControlState;
  final StateTheming criticalControlState;
  // StateTheming
 const TWSFThemeBase(
    super.identifier, {
      super.frame,
      required this.page,
      required this.masterLayout,
      required this.primaryControlState,
      required this.primaryControlColor,
      required this.criticalControlState,
      required this.masterLayoutMenuButtonState,
      required this.primaryCriticalControl,
      required this.articlesLayoutActionButtonState,
      required this.primaryDisabledControl,
      required this.articlesLayoutSelectorButtonState, 
      required super.icon, 
      required super.iconBackground,
    } 
  );

}