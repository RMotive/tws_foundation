import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Defines a contract to store information for a [CategoryLayout] entry options, drawing it's article button and handling its routing
/// behavior.
abstract interface class CategoryLayoutEntryI {
  /// Button title.
  final String title;

  /// Button target routing.
  final Route route;

  /// [RouteNode] page builder for routing management.
  final PageBuilder pageBuilder;

  /// Action ribbon controller.
  final CategoryLayoutRibbonControllerI? ribbonController;

  /// Button icon builder.
  ///
  /// [foreColor] recommended current theme fore color.
  final Widget Function(Color? foreColor) iconBuilder;

  /// Creates a new [CategoryLayoutEntryI] instance.
  const CategoryLayoutEntryI({
    required this.title,
    required this.route,
    this.ribbonController,
    required this.pageBuilder,
    required this.iconBuilder,
  });
}

/// {article} class.
///
/// Implements an article entry for [CategoryLayout] specifying what [PageI] to draw and hwo to handle routing behavior,
/// also controlles [CategoryLayout] ribbon invokations.
final class CategoryLayoutEntry extends CategoryLayoutEntryI {
  /// Creates a new [CategoryLayoutEntry] instance.
  const CategoryLayoutEntry({
    required super.title,
    required super.route,
    super.ribbonController,
    required super.pageBuilder,
    required super.iconBuilder,
  });
}
