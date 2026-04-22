import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


abstract class _ViewRoot extends ViewModuleBase with ConsoleMixin {
  /// Creates a new [_ViewRoot] instance.
  const _ViewRoot({
    required this.routerConfig,
    required this.onInitView,
  });

  /// Router configuration for the view.
  final RoutingGraphBase routerConfig;

  /// View initialization callback.
  final FutureOr<void> Function(BuildContext context) onInitView;

  @override
  List<IThemeData> bootstrapTheming() {
    final List<FoundationThemeB> themes = <FoundationThemeB>[
      FoundationThemeDark(),
      FoundationThemeLight(),
    ];

    return themes;
  }

}

final class _SecurityViewRoot extends _ViewRoot {
  /// Creates a new [_SecurityViewRoot] instance.
  const _SecurityViewRoot({
    required super.routerConfig,
    required super.onInitView,
  });

  @override
  List<IRoutingGraphData> bootstrapRouting() {
    return routerConfig.routes;
  }

  @override
  FutureOr<void> initView(BuildContext context) {
    return onInitView(context);
  }

}

/// {application} class.
///
/// Handles the default behavior and configurations for a {csm foundation} view solution that requires authentication
/// and secure functions.
final class FoundationSecureView extends StatefulWidget {
  /// Solution sign identifier.
  final String sign;

  /// Application RouteData tree.
  final List<RoutingGraphNode> routes;

    /// View initialization callback.
  final FutureOr<void> Function(BuildContext context) onInitView;

  /// Creates a new [FoundationSecureView] instance.
  const FoundationSecureView({
    super.key,
    required this.sign,
    required this.onInitView,
    this.routes = const <RoutingGraphNode>[],

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
    
    return _SecurityViewRoot(
      onInitView: widget.onInitView,
      routerConfig: _FoundationSecureViewRouteTree(
        solutionSign: widget.sign,
        routes: widget.routes,
      ),
    );
  }
}

/// {router tree} class.
final class _FoundationSecureViewRouteTree extends RoutingGraphBase {
  /// Creates a new [_FoundationSecureViewRouteTree] instance.
  _FoundationSecureViewRouteTree({
    required String solutionSign,
    List<RoutingGraphNode> routes = const <RoutingGraphNode>[],
  }) : super(
         routes: <RoutingGraphDataBase>[
          RoutingGraphNode(
            FoundationRoutes.authRoute,
            pageBuilder: (BuildContext ctx, RoutingData routeData) {
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
