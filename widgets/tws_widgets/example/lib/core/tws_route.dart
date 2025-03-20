import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:example/core/landing_view/landing_view_page.dart';

class TWSFRoutes {
  static const CSMRouteOptions landingView = CSMRouteOptions("/");
}
class TWSFRoutesTree extends CSMRouterTreeBase {
  static FutureOr<CSMRouteOptions?> redirect(_, __) {
    return TWSFRoutes.landingView;
  }
  TWSFRoutesTree() : super(
    redirect: (_, _) {
      return TWSFRoutes.landingView;
    },
    routes: <CSMRouteBase>[
      // --> [Landing view]
      CSMRouteNode(
        TWSFRoutes.landingView, 
        redirect: redirect,
        pageBuild:(_, _) => LandingViewPage(),
      ),
    ],
  );
}
