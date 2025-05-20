import 'package:csm_view/csm_view.dart';

/// [abstract] class definition.
///
/// Defines a base contract theme for any {TWS Foundation View} usage.
abstract class TWSFThemeB extends ThemeB {
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

  const TWSFThemeB(
    super.identifier, {
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
  });
}
