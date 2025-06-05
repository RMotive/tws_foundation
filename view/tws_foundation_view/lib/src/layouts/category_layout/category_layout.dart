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

///
final class CategoryLayoutNode extends RouteLayoutB {
  ///
  final List<CategoryLayoutEntryI> articles;

  /// Creates a new []
  CategoryLayoutNode({
    required this.articles,
  }) : super(
         routes: <RouteB>[
           for (CategoryLayoutEntryI article in articles)
             RouteNode(
               article.route,
               pageBuilder: article.pageBuilder,
             ),
         ],
         layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
           return CategoryLayout(
             page: page,
             articles: articles,
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
  final List<CategoryLayoutEntryI> articles;

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
