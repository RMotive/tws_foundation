import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {abstract} class.
///
/// Defines a base abstraction from [CategoryLayoutPageI] implementations based on {entity} context, representing
/// the complex UI draw base required behaviors for an {entity} category page and its interactions.
abstract class EntityCategoryPageB<TAdapter extends EntityTableAdapterI> implements CategoryLayoutPageI {
  @override
  final String title;

  @override
  final Route route;

  @override
  late final CategoryLayoutRibbonControllerI? ribbonController;

  /// Authentication token builder since {foundation} package doesn't have access to application context session control.
  final AuthBuilder? _authBuilder;

  /// Gets a valid [AuthBuilder] after validating if a overrideable [AuthBuilder] was given, if not will build one from [SessionStorage] at [Injector].
  AuthBuilder get authBuilder {
    if (_authBuilder != null) return _authBuilder;

    SessionStorage sessionStore = Injector.get();
    return () => sessionStore.get();
  }

  /// Allows to override default [EntityCategoryPageB] route configuration to provide a custom [Route] instance.
  final Route? cusRoute;

  /// Inner [EntityTable] adapter.
  late final TAdapter adapter;

  /// Creates a new [EntityCategoryPageB] instance.
  EntityCategoryPageB({
    this.cusRoute,
    FutureOr<String> Function()? authBuilder,
    required this.title,
    required Route route,
  }) : _authBuilder = authBuilder,
       route = cusRoute ?? route {
    adapter = composeAdapter();
    ribbonController = composeRibbonController(adapter);
  }

  /// Composes the required [TAdapter] instance to use at the inner [EntityTable] at the entity page.
  TAdapter composeAdapter();

  /// Composes the required {controller} for the inner [CategoryLayout] ribbon actions controlling.
  CategoryLayoutRibbonControllerI composeRibbonController(TAdapter adapter);

  @override
  List<RouteB> composeRoutes() => <RouteB>[];
}
