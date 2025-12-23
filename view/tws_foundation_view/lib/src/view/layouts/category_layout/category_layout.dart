import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_view/src/core/models/user_feedback.dart';
import 'package:tws_foundation_view/src/view/widgets/bordered_box.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_category_layout_messenger.dart';
part '_category_layout_ribbon/_category_layout_ribbon.dart';

/// Handles the convertion of a [CategoryLayoutNode] to its [RouteNode] representation for a [RouteLayoutI], generating correctly the
/// [LayoutI], and inner [RouteNodeI]s composition.
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
               routes: page.composeRoutes(),
               pageBuilder: page.composePage,
             ),
         ],
         layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
           return CategoryLayout(
             page: page,
             pages: pages,
             routeData: routeData,
           );
         },
       );
}

/// Draws [LayoutI] implementation for a {Category} concept wich holds and routes along several {EntityPages} / {Pages} with their own
/// actions and behaviors, draws an actions ribbon handled layout and inner paging routing behaviors.
final class CategoryLayout extends LayoutB {
  /// Category pages.
  final List<CategoryLayoutPageI> pages;

  /// Creates a new [CategoryLayout] instance.
  const CategoryLayout({
    required super.page,
    required super.routeData,
    required this.pages,
  }) : assert(pages.length > 0, 'Must be at least one article configured');

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final GlobalKey<CategoryLayoutMessengerState> messengerRef = GlobalKey();

    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: Column(
        children: <Widget>[
          /// --> Action/Navigation Ribbons
          _CategoryLayoutRibbon(
            pages: pages,
            messengerRef: messengerRef,
            currentRoute: routeData.route,
          ),

          /// --> Content Box (message system/page content)
          Expanded(
            child: Stack(
              children: <Widget>[
                /// Page Content
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: page,
                ),

                /// Messaging system.
                _CategoryLayoutMessenger(
                  key: messengerRef,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
