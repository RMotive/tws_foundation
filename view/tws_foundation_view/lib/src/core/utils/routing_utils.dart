import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {utility} class.
/// Stores utility methods related to routing, such as redirection methods for unauthorized and authorized users.
class RoutingUtils {
  /// Redirects the user to the [AuthPage] when it is not authorized yet and is trying to access a route different than [FoundationRoutes.authRoute].

  static FutureOr<RouteData?> redirectUnauthorized(BuildContext buildContext, RoutingData routeData, RoutingData homeRouteData) {
    final SessionStorage sessionStorage = InjectorUtils.get();

    if (routeData.targetRoute == FoundationRoutes.authRoute) {
      return redirectAuthorized(buildContext, routeData);
    }

    if (sessionStorage.isActive) return null;
    return FoundationRoutes.authRoute;
  }

  /// Redirects the user to the [---] when it is authorized and is trying to access [FoundationRoutes.authRoute] route.
  static FutureOr<RouteData?> redirectAuthorized(BuildContext _, RoutingData routeData) {
    final SessionStorage sessionStorage = InjectorUtils.get();

    if (!sessionStorage.isActive) return null;
    return FoundationRoutes.yardlogsPageRoute;
  }
}