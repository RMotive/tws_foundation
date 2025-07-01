import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/loading_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} {business} class.
final class CatalogOptionsSelector<TEntity extends NamedEntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends StatefulWidget {
  /// Entity builder for construction.
  final EntityBuilder<TEntity> entityBuilder;

  /// Overriden session auth builder for service call authentication, if not given, [SessionStorage] will be used
  final AuthBuilder? authBuilder;

  /// Whether the options multiselection is enabled
  final bool multiSelection;

  /// {event} callback triggered when options selection has changed.
  final void Function(List<TEntity> selection) onSelect;

  /// Creates a new [CatalogOptionsSelector] instance.
  const CatalogOptionsSelector({
    super.key,
    this.authBuilder,
    this.multiSelection = false,
    required this.onSelect,
    required this.entityBuilder,
  });

  @override
  State<CatalogOptionsSelector<TEntity, TService>> createState() => _CatalogOptionsSelectorState<TEntity, TService>();
}

/// {state} class.
///
/// Handles [State] for [CatalogOptionsSelector].
final class _CatalogOptionsSelectorState<TEntity extends NamedEntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends State<CatalogOptionsSelector<TEntity, TService>> {
  /// {dep} entity service instance dependency.
  final TService entityService = Injector.get();

  /// {state} current service invokation instance.
  late Future<ViewOutput<TEntity>> _viewInvok;

  /// {state} current application theme data.
  late FoundationThemeB fountTheming = Theming.get(context);

  @override
  void initState() {
    super.initState();

    _viewInvok = viewInvokation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    fountTheming = Theming.get(context);
  }

  /// Generates a new [Future] instance to handle along state persistive data for the [ViewOutput] of the catalog options
  /// gathering.
  Future<ViewOutput<TEntity>> viewInvokation() async {
    String auth;

    if (widget.authBuilder != null) {
      auth = await widget.authBuilder!();
    } else {
      SessionStorage sessionStorage = Injector.get();
      auth = sessionStorage.get();
    }

    FoundationResponseResolver<ViewOutput<TEntity>> futureResolver = await entityService.view(
      ViewInput<TEntity>.b(2000, 1),
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
      loadingBuilder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsetsGeometry.all(4),
          child: Center(
            child: LoadingWidget(
              foreColor: fountTheming.page.fore,
            ),
          ),
        );
      },
      successBuilder: (BuildContext ctx, ViewOutput<TEntity> data) {
        List<TEntity> options = data.entities;

        if (options.isEmpty) {
          return Center(
            child: Text(
              'No values to display',
              style: TextStyle(
                color: fountTheming.page.fore,
              ),
            ),
          );
        }

        return OptionsSelector<TEntity>(
          options: <OptionsSelectorOption<TEntity>>[
            for (TEntity option in options)
              OptionsSelectorOption<TEntity>(
                title: option.name,
                value: option,
              ),
          ],
          onSelect: widget.onSelect,
        );
      },
    );
  }
}
