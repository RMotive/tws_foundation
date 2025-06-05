import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// [abstract] class definition.
///
/// Defines a base contract theme for any {TWS Foundation View} usage.
abstract class FoundationThemeB extends ThemeB {
  ///
  final String businessLogo;

  ///
  final SimpleTheming page;

  ///
  final SimpleTheming navigationLayout;

  /// Theming for [CategoryLayout] ribbon buttons.
  final StateTheming categoryLayoutRibbonButton;

  ///
  final SimpleTheming primaryControlColor;
  final SimpleTheming primaryDisabledControl;
  final SimpleTheming primaryCriticalControl;

  final StateTheming masterLayoutMenuButtonState;
  final StateTheming primaryControlState;
  final StateTheming criticalControlState;

  const FoundationThemeB(
    super.identifier, {
    required this.businessLogo,
    required this.categoryLayoutRibbonButton,
    required this.page,
    required this.navigationLayout,
    required this.primaryControlState,
    required this.primaryControlColor,
    required this.criticalControlState,
    required this.masterLayoutMenuButtonState,
    required this.primaryCriticalControl,
    required this.primaryDisabledControl,
    required super.icon,
    required super.iconBackground,
  });
}
