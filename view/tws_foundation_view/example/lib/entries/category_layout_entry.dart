import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';

///
final class CategoryLayoutEntry extends PackageLandingEntryBase<LandingThemeB> {
  ///
  CategoryLayoutEntry({
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
    final RouteData entryRoute = RouteData('landing_page');

    return CategoryLayout(
      pages: <CategoryLayoutPage>[
        CategoryLayoutPage(
          routeData: entryRoute,
          title: 'Landing Overview',
          actions: <IActionsRibbonNode>[],
          pageBuilder: (BuildContext ctx, RoutingData routeData) => _EntryPage(),
          iconBuilder: (_, Color? foreColor) {
            return Icon(
              Icons.ac_unit_sharp,
              color: foreColor,
            );
          },

        ),
      ],
      routingData: RoutingData(
        targetRoute: entryRoute,
        absolutePath: '',
      ),
      page: _EntryPage(),
    );
  }
}

final class _EntryPage extends ViewPageBase {
  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Center(
      child: Text(
        'Landing Category Layout Page',
      ),
    );
  }
}
