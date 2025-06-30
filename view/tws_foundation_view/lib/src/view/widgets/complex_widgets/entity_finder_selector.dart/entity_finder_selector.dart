import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} class.
///
/// Draws a complex [Widget] that allows to find [EntityI] items and select them.
final class EntityFinderSelector<TEntity extends EntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends StatefulWidget {
  /// Input label decorator.
  final String? label;

  /// Creates a new [EntityFinderSelector] instance.
  const EntityFinderSelector({
    super.key,
    this.label,
  });

  @override
  State<EntityFinderSelector<TEntity, TService>> createState() => _EntityFinderSelectorState<TEntity, TService>();
}

/// {state} class.
///
/// Handles [State] for [EntityFinderSelector].
final class _EntityFinderSelectorState<TEntity extends EntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends State<EntityFinderSelector<TEntity, TService>> {
  /// {dep} [TEntity] based service dependency.
  final TService service = Injector.get();

  /// {state} current application theme data.
  late FoundationThemeB theme = Theming.get(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = Theming.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextInput(
      label: widget.label,
      suffixIcon: Icon(
        Icons.arrow_drop_down,
        size: 32,
        color: theme.page.fore,
      ),
    );
  }
}
