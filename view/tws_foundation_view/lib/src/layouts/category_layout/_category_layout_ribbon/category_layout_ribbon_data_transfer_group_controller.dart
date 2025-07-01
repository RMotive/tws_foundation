import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Defines a contract to handle {DataTransfer} froup at [CategoryLayout] action ribbon behaviors.
abstract interface class CategoryLayoutRibbonDataTransferGroupControllerI {
  /// Invokation when {export} button is clicked.
  final VoidCallback? onExport;

  /// Creates a new [CategoryLayoutRibbonDataTransferGroupControllerI] instance.
  const CategoryLayoutRibbonDataTransferGroupControllerI({
    this.onExport,
  }) : assert(onExport != null, 'At least an action invokation must be provided');
}

/// {controller} class.
///
/// Implements behavior controlling for [CategoryLayout] action ribbon {DataTransfer} actions group.
final class CategoryLayoutRibbonDataTransferGroupController extends CategoryLayoutRibbonDataTransferGroupControllerI {
  /// Creates a new [CategoryLayoutRibbonDataTransferGroupController] instance.
  const CategoryLayoutRibbonDataTransferGroupController({
    super.onExport,
  });
}
