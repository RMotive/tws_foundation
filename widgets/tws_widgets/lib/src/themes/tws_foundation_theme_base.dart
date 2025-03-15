import 'package:csm_view/csm_view.dart';

abstract class TWSFThemeBase extends CSMThemeBase{
  final CSMColorThemeOptions page;
  final CSMColorThemeOptions masterLayout;
  final CSMColorThemeOptions primaryControlColor;
  final CSMColorThemeOptions primaryDisabledControl;
  final CSMColorThemeOptions primaryCriticalControl;
  final CSMStateThemeOptions masterLayoutMenuButtonState;
  final CSMStateThemeOptions articlesLayoutActionButtonState;
  final CSMStateThemeOptions articlesLayoutSelectorButtonState;
  final CSMStateThemeOptions primaryControlState;
  final CSMStateThemeOptions criticalControlState;

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
    } 
  );

}