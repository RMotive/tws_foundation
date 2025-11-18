import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {entry} class.
///
/// Implements a [PackageLandingEntryB] for [LocationsPage] from {tws_foundation_view} package as part of the package landing playground.
final class SectionsCategoryPageEntry extends PackageLandingEntryB<LandingThemeB> {
  late final CategoryLayoutPageI categoryPage;

  /// Creates a new [SectionsCategoryPageEntry] instance.
  SectionsCategoryPageEntry({
    super.key,
  }) : super(
         name: 'Sections Category Page',
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'A Sections Category page provides visual interaction with the business entity management operations',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       ) {
    categoryPage = SectionsCategoryPage();
  }

  @override
  List<RouteB> composeRoutes(_, _) {
    return categoryPage.composeRoutes();
  }

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    RouteData routeData = RouteData(
      route: categoryPage.route,
      absolutePath: '/sections_category_page',
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
