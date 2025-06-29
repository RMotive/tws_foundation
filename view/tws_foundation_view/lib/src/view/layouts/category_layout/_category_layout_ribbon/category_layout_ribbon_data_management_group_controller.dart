import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Defines a contract to handle {DataManagement} froup at [CategoryLayout] action ribbon behaviors.
abstract interface class CategoryLayoutRibbonDataManagementGroupControllerI {
  /// Invokation when {remove} button is clicked.
  final VoidCallback? onRemove;

  /// Invokation when {create} button is clicked.
  final VoidCallback? onCreate;

  /// Invokation when {edit} button is clicked.
  final VoidCallback? onEdit;

  /// Creates a new [CategoryLayoutRibbonDataManagementGroupControllerI] instance.
  const CategoryLayoutRibbonDataManagementGroupControllerI({
    this.onEdit,
    this.onCreate,
    this.onRemove,
  }) : assert(onRemove != onCreate || onRemove != onCreate, 'At least an action invokation must be provided');
}

/// {controller} class.
///
/// Implements behavior controlling for [CategoryLayout] action ribbon {DataManagement} actions group.
final class CategoryLayoutRibbonDataManagementGroupController
    extends CategoryLayoutRibbonDataManagementGroupControllerI {
  /// Creates a new [CategoryLayoutRibbonDataManagementGroupController] instance.
  const CategoryLayoutRibbonDataManagementGroupController({
    super.onRemove,
    super.onCreate,
    super.onEdit,
  });
}
