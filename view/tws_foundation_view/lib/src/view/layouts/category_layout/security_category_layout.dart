
import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

final class SecurityCategoryLayout extends ViewPageBase {
  const SecurityCategoryLayout({super.key});
      
  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    RoutingData routeData = const RoutingData(
      targetRoute: FoundationRoutes.securityCategoryRoute,
      absolutePath: '/security_category',
    );

    return CategoryLayout(
      pages: <ICategoryLayoutPage>[
        SolutionsCategoryPage(),
      ],
      page: SolutionsCategoryPage().composePage(buildContext, routeData), 
      routingData: routeData,
    );
  }
  
}
