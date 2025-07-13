import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Defines the theme data base contract for {Foundation View} solution.
abstract class FoundationThemeB extends ThemeDataB {
  //! --> [Asset]s access.

  /// Business main logo asset access.
  final String businessLogo;

  //! <-- [Asset]s access

  //! --> [Scoped] theme data

  /// [EntityTable] theme data.
  final EntityTableTheming entityTable;

  /// [NavigationLayout] theme data.
  final SimpleTheming navigationLayout;

  /// [CategoryLayout] ribbon buttons theme data.
  final StateTheming categoryLayoutRibbonButton;

  //! <-- [Scoped] theme data

  /// Main appliation pages theme data.
  final SimpleTheming page;

  /// {error} scenarios theme data.
  final SimpleTheming error;

  /// {warning} scenarios theme data.
  final SimpleTheming warning;

  /// {success} scenarios theme data.
  final SimpleTheming success;

  /// {disabled} scenarios theme data
  final SimpleTheming disabled;

  /// Main {controls} [Widget]s theme data.
  final SimpleTheming control;

  /// Creates a new [FoundationThemeB] instance.
  const FoundationThemeB(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required this.businessLogo,
    required this.page,
    required this.error,
    required this.warning,
    required this.success,
    required this.control,
    required this.disabled,
    required this.navigationLayout,
    required this.categoryLayoutRibbonButton,
    required this.entityTable,
  });
}
