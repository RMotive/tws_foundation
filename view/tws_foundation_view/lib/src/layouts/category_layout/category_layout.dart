import 'dart:async';

import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_category_layout_ribbon/_category_layout_ribbon.dart';
part '_category_layout_ribbon/_category_layout_ribbon_section.dart';
part '_category_layout_ribbon/_category_layout_ribbon_article_button.dart';
part '_category_layout_ribbon/_category_layout_ribbon_action_button.dart';

part '_category_layout_ribbon/category_layout_ribbon_node_i.dart';
part '_category_layout_ribbon/category_layout_ribbon_action_options.dart';
part '_category_layout_ribbon/_category_layout_ribbon_group_options.dart';

/// {layout route node} class.
/// 
/// Implements a [RouteLayoutB] storing default configuration for a correct {layout} type [RouteNode] usage at the [Router] tree.
final class CategoryLayoutNode extends RouteLayoutB {
  /// Pages grouped at this category.
  final List<CategoryLayoutPageI> pages;

  /// Creates a new [CategoryLayoutNode] instance.
  CategoryLayoutNode({
    required this.pages,
  }) : super(
         routes: <RouteB>[
           for (CategoryLayoutPageI page in pages)
             RouteNode(
               page.route,
               pageBuilder: page.composePage,
             ),
         ],
         layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
           return CategoryLayout(
             page: page,
             articles: pages,
             routeData: routeData,
           );
         },
       );
}

///
final class CategoryLayout extends LayoutB {
  ///
  final RouteData routeData;

  ///
  final List<CategoryLayoutPageI> articles;

  /// Creates a new [CategoryLayout] instance.
  const CategoryLayout({
    required super.page,
    required this.articles,
    required this.routeData,
  }) : assert(articles.length > 0, 'Must be at least one article configured');

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: Column(
        children: <Widget>[
          _CategoryLayoutRibbon(
            articles: articles,
            currentRoute: routeData.route,
          ),
          Expanded(
            child: page,
          ),
        ],
      ),
    );
  }
}
