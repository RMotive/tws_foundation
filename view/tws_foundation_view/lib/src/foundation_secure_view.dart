import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {application} class.
///
/// Handles the default behavior and configurations for a {csm foundation} view solution that requires authentication
/// and secure functions.
final class FoundationSecureView extends StatefulWidget {
  /// Solution sign identifier.
  final String sign;

  /// Application route tree.
  final List<RouteB> routes;

  /// Creates a new [FoundationSecureView] instance.
  const FoundationSecureView({
    super.key,
    required this.sign,
    this.routes = const <RouteB>[],
  });

  @override
  State<FoundationSecureView> createState() => _FoundationSecureViewState();
}

/// {state} class.
///
/// Handles [State] for [FoundationSecureView].
final class _FoundationSecureViewState extends State<FoundationSecureView> {
  @override
  Widget build(BuildContext context) {
    return ViewRoot(
      routerConfig: _FoundationSecureViewRouteTree(
        solutionSign: widget.sign,
        routes: widget.routes,
      ),
    );
  }
}

/// {router tree} class.
final class _FoundationSecureViewRouteTree extends RouterTreeB {
  /// Creates a new [_FoundationSecureViewRouteTree] instance.
  _FoundationSecureViewRouteTree({
    required String solutionSign,
    List<RouteB> routes = const <RouteB>[],
  }) : super(
         routes: <RouteB>[
           RouteNode(
             FoundationRoutes.authRoute,
             pageBuilder: (BuildContext ctx, RouteData routeData) {
               return AuthPage(
                 solutionSign: solutionSign,
                 onAuthSuccess: (SessionData serverSession) {},
               );
             },
           ),
           ...routes,
         ],
       );
}
