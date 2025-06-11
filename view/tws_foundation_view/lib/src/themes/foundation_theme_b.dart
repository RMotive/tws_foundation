import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {abstract} class.
///
/// Defines a base contract theme for any {TWS Foundation View} usage.
abstract class FoundationThemeB extends ThemeB {
  /// Main application page theming properties.
  final SimpleTheming page;

  /// Business main logo asset access.
  final String businessLogo;

  /// Theming for {error} scenarios usually around red color.
  final SimpleTheming errorTheming;

  /// Theming for {warning} scenearios usually around yellow color.
  final SimpleTheming warnTheming;

  /// Theming for {success} scenarios usually around green color.
  final SimpleTheming succTheming;

  /// Theming for [NavigationLayout].
  final SimpleTheming navigationLayout;

  /// Theming for {csm} main {widget}s that have state like hover, selected, etc.
  final SimpleTheming primControl;

  /// Theming for [CategoryLayout] ribbon buttons.
  final StateTheming categoryLayoutRibbonButton;

  /// Stores the [EntityTable] default theming options.
  final EntityTableTheming entityTableTheming;

  const FoundationThemeB(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required this.page,
    required this.businessLogo,
    required this.errorTheming,
    required this.warnTheming,
    required this.succTheming,
    required this.primControl,
    required this.navigationLayout,
    required this.categoryLayoutRibbonButton,
    required this.entityTableTheming,
  });
}
