import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {abstract} class.
///
/// Defines a base abstraction from [ICategoryLayoutPage] implementations based on {entity} context, representing
/// the complex UI draw base required behaviors for an {entity} category page and its interactions.
abstract class EntityCategoryPageB<TEntity extends IEntity<TEntity>, TAdapter extends IEntityTableAdapter<TEntity>> implements ICategoryLayoutPage {
  @override
  final String title;

  @override
  final RouteData routeData;

  @override
  late final List<IActionsRibbonNode>? actions;

  /// Authentication token builder since {foundation} package doesn't have access to application context session control.
  final AuthBuilder? _authBuilder;

  /// Gets a valid [AuthBuilder] after validating if a overrideable [AuthBuilder] was given, if not will build one from [SessionStorage] at [InjectorUtils].
  AuthBuilder get authBuilder {
    if (_authBuilder != null) return _authBuilder;

    SessionStorage sessionStore = InjectorUtils.get();
    return () => sessionStore.token;
  }

  /// Allows to override default [EntityCategoryPageB] route configuration to provide a custom [RouteData] instance.
  final RouteData? cusRoute;

  /// Inner [EntityTable] adapter.
  late final TAdapter adapter;

  /// Creates a new [EntityCategoryPageB] instance.
  EntityCategoryPageB({
    this.cusRoute,
    FutureOr<String> Function()? authBuilder,
    required this.title,
    required RouteData routeData,
  }) : _authBuilder = authBuilder,
       routeData = cusRoute ?? routeData {
    adapter = composeAdapter();
    actions = composeRibbonController(adapter);
  }

  /// Composes the required [TAdapter] instance to use at the inner [EntityTable] at the entity page.
  TAdapter composeAdapter();

  /// Composes the required {controller} for the inner [CategoryLayout] ribbon actions controlling.
  List<IActionsRibbonNode> composeRibbonController(TAdapter adapter);

  
}
