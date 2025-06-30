import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} {business} class.
final class CatalogOptionsSelector<TEntity extends EntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends StatefulWidget {
  /// Entity builder for construction.
  final EntityBuilder<TEntity> entityBuilder;

  /// Overriden session auth builder for service call authentication, if not given, [SessionStorage] will be used
  final AuthBuilder? authBuilder;

  /// Creates a new [CatalogOptionsSelector] instance.
  const CatalogOptionsSelector({
    super.key,
    this.authBuilder,
    required this.entityBuilder,
  });

  @override
  State<CatalogOptionsSelector<TEntity, TService>> createState() => _CatalogOptionsSelectorState<TEntity, TService>();
}

/// {state} class.
///
/// Handles [State] for [CatalogOptionsSelector].
final class _CatalogOptionsSelectorState<TEntity extends EntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends State<CatalogOptionsSelector<TEntity, TService>> {
  /// {dep} entity service instance dependency.
  final TService entityService = Injector.get();

  /// {state} current service invokation instance.
  late Future<ViewOutput<TEntity>> _viewInvok;

  @override
  void initState() {
    super.initState();

    _viewInvok = viewInvokation();
  }

  ///
  Future<ViewOutput<TEntity>> viewInvokation() async {
    String auth;

    if (widget.authBuilder != null) {
      auth = await widget.authBuilder!();
    } else {
      SessionStorage sessionStorage = Injector.get();
      auth = sessionStorage.get();
    }

    FoundationResponseResolver<ViewOutput<TEntity>> futureResolver = await entityService.view(
      ViewInput<TEntity>.b(
        double.maxFinite.toInt(),
        1,
      ),
      auth,
    );

    return futureResolver.resolveDirect(
      () => ViewOutput<TEntity>(widget.entityBuilder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<ViewOutput<TEntity>>(
      future: _viewInvok,
      successBuilder: (BuildContext ctx, ViewOutput<TEntity> data) {
        return SizedBox();
      },
    );
  }
}
