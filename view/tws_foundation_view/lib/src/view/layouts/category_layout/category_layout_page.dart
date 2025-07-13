
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Defines a contract to store information for a [CategoryLayout] entry options, drawing it's article button and handling its routing
/// behavior.
abstract interface class CategoryLayoutPageI {
  /// Button title.
  final String title;

  /// Page target [Route] object instance.
  final Route route;

  /// Category page action ribbon configuration.
  final List<ActionsRibbonNodeI>? actions;

  /// Creates a new [CategoryLayoutPageI] instance.
  const CategoryLayoutPageI({
    required this.title,
    required this.route,
    this.actions,
  });

  /// Composes the inner [CategoryLayout] entry nested [RouteB] implementations, used to subscribe dinamic routes subscription for this entry
  /// [RouteNode] created providing routing access from inner [CategoryLayoutRibbonControllerI] interactions.
  List<RouteB> composeRoutes();

  /// Composes customly a [Widget] to replace the default [CategoryLayout] page selection button icon decorator.
  ///
  ///
  /// [recomdColor] recommended fore icon [Color] calculated based on the current {CSM} foundation theming management.
  Widget? composeIcon(Color? recomdColor);

  /// Composes the [PageI] implementation that will be drawn into this [CategoryLayout] page entry.
  PageI composePage(BuildContext buildContext, RouteData routeData);
}

/// {page} class.
///
/// Implements an article entry for [CategoryLayout] specifying what [PageI] to draw and hwo to handle routing behavior,
/// also controlles [CategoryLayout] ribbon invokations.
final class CategoryLayoutPage extends CategoryLayoutPageI {
  /// [RouteNode] page builder for routing management.
  final PageBuilder pageBuilder;

  /// Button icon builder.
  ///
  /// [foreColor] recommended current theme fore color.
  final Widget Function(Color? foreColor) iconBuilder;

  /// Builds inner [CategoryLayoutPage] nested [RouteB] implementations to be accessable.
  final List<RouteB> Function()? routesBuilder;

  /// Creates a new [CategoryLayoutPage] instance.
  const CategoryLayoutPage({
    required super.title,
    this.routesBuilder,
    required super.route,
    super.actions,
    required this.pageBuilder,
    required this.iconBuilder,
  });

  @override
  List<RouteB> composeRoutes() => routesBuilder?.call() ?? <RouteB>[];

  @override
  Widget? composeIcon(Color? recomdColor) => iconBuilder(recomdColor);

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) => pageBuilder(buildContext, routeData);
}
