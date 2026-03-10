import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {entry} class.
///
/// Implements a [PackageLandingEntryBase] for [DriversPage] from {tws_foundation_view} package as part of the package landing playground.
final class DriversCategoryPageEntry extends PackageLandingEntryBase<LandingThemeB> {
  late final ICategoryLayoutPage categoryPage;

  /// Creates a new [DriversCategoryPageEntry] instance.
  DriversCategoryPageEntry({
    super.key,
  }) : super(
         name: 'Drivers Category Page',
         image: AssetImage(FoundationAssets.categoryPagePreview),
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'An Drivers Category page provides visual interaction with the business entity management operations',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       ) {
    categoryPage = DriversCategoryPage();
  }

  @override
  List<IRoutingGraphData> composeRoutes(_, _) {
    return categoryPage.composeRoutes();
  }

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    RoutingData routeData = RoutingData(
      targetRoute: categoryPage.routeData,
      absolutePath: '/drivers_category_page',
    );

    return CategoryLayout(
      pages: <ICategoryLayoutPage>[
        categoryPage,
      ],
      routingData: routeData,
      page: categoryPage.composePage(buildContext, routeData),
    );
  }
}
