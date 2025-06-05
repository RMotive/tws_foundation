import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:tws_foundation_view/tws_foundation_view.dart' as view;
import 'package:tws_foundation_view/tws_foundation_view.dart' show CategoryLayoutEntry;

///
final class CategoryLayout extends PackageLandingEntryB<LandingThemeB> {
  ///
  CategoryLayout({
    super.key,
  }) : super(
         name: 'Category Layout',
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'Draws a complex layout for categories along application navigations, enabling action ribbons to interact with the page and navigation along the inner category',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    final Route entryRoute = Route('landing_page');

    return view.CategoryLayout(
      articles: <view.CategoryLayoutEntryI>[
        CategoryLayoutEntry(
          route: entryRoute,
          title: 'Landing Overview',
          pageBuilder: (BuildContext ctx, RouteData routeData) => _EntryPage(),
          ribbonController: view.CategoryLayoutRibbonController(
            onRefresh: () async {
              await Future<void>.delayed(3.seconds);
            },
          ),
          iconBuilder: (Color? foreColor) {
            return Icon(
              Icons.ac_unit_sharp,
              color: foreColor,
            );
          },
        ),
      ],
      routeData: RouteData(
        route: entryRoute,
        absolutePath: '',
      ),
      page: _EntryPage(),
    );
  }
}

final class _EntryPage extends PageB {
  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Center(
      child: Text(
        'Landing Category Layout Page',
      ),
    );
  }
}
