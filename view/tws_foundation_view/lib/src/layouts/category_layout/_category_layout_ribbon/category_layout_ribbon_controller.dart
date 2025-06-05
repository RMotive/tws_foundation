import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Defines a contract that works as a controller for [CategoryLayout] actions ribbon behavior.
abstract interface class CategoryLayoutRibbonControllerI {
  /// Callback performed when the {refresh} action button is clicked.
  final VoidCallback? onRefresh;

  /// {DataManagement} group invokations controller.
  final CategoryLayoutRibbonDataManagementGroupControllerI? dataManagementController;

  /// {DataTransfer} group invokations controller.
  final CategoryLayoutRibbonDataTransferGroupControllerI? dataTransferController;

  /// Validates based on the configuration if the actions ribbon must be drawn.
  bool validate();

  /// Creates a new [CategoryLayoutRibbonControllerI] instance.
  const CategoryLayoutRibbonControllerI({
    this.onRefresh,
    this.dataTransferController,
    this.dataManagementController,
  });
}

/// {controller} class.
///
/// Implements the behavior to handle [CategoryLayout] action ribbon for {article} scope.
final class CategoryLayoutRibbonController extends CategoryLayoutRibbonControllerI {
  /// Creates a new [CategoryLayoutRibbonController] instance.
  const CategoryLayoutRibbonController({
    super.onRefresh,
  });

  @override
  bool validate() {
    bool initVal = false;
    if (onRefresh != null) return true;
    if (dataTransferController != null) return true;
    if (dataManagementController != null) return true;

    return initVal;
  }
}
