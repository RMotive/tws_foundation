import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {entry} class.
///
/// Implements a [PackageLandingEntryB] for [TrailersInventoryPage] from {tws_foundation_view} package as part of the package landing playground.
final class TrailersInventoryCategoryPageEntry extends PackageLandingEntryB<LandingThemeB> {
  late final CategoryLayoutPageI categoryPage;

  /// Creates a new [TrailersInventoryCategoryPageEntry] instance.
  TrailersInventoryCategoryPageEntry({
    super.key,
  }) : super(
         name: 'Trailers Inventory Category Page',
         image: AssetImage(FoundationAssets.categoryPagePreview),
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'An Trailers inventory Category page provides visual interaction with the business entity management operations',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       ) {
    categoryPage = TrailersInventoryCategoryPage();
  }

  @override
  List<RouteB> composeRoutes(_, _) {
    return categoryPage.composeRoutes();
  }

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    RouteData routeData = RouteData(
      route: categoryPage.route,
      absolutePath: '/trailers_inventory_category_page',
    );

    return CategoryLayout(
      pages: <CategoryLayoutPageI>[
        categoryPage,
      ],
      routeData: routeData,
      page: categoryPage.composePage(buildContext, routeData),
    );
  }
}
