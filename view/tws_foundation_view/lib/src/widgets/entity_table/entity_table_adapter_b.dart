import 'package:csm_client/csm_client.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {model} class.
///
/// Defines a data model to store on remove event configruation for [EntityTableAdapterB.composeDeleter].
final class EntityTableAdapterDeleter<TEntity> {
  /// Callback invoked when the user request to delete an [EntityTable] entity.
  ///
  ///
  /// [buildContext] current [Widget] tree calcualted context.
  ///
  /// [entity] entity requested to be removed.
  final void Function(BuildContext buildContext, TEntity entity) callback;

  /// Creates a new [EntityTableAdapterDeleter] instance.
  const EntityTableAdapterDeleter({
    required this.callback,
  });
}

/// {widget} class.
///
/// Defines a data model to store editor conifguration for [EntityTableAdapterB.composeEditor].
final class EntityTableAdapterEditor<TEntity> {
  /// {event} triggered when edition is being saved.
  ///
  ///
  /// [buildContext] built-in [Widget] tree reference context.
  ///
  /// [entity] updated [TEntity] instance.
  final void Function(BuildContext buildContext, TEntity entity) onUpdate;

  /// Editor form building function.
  /// 
  /// 
  /// [buildContext] built-in [Widget] tree reference context.
  ///
  /// [entity] entity instance being edited.
  final Widget Function(BuildContext buildContext, TEntity entity) formBuilder;

  /// Creates a new [EntityTableAdapterEditor] instance.
  const EntityTableAdapterEditor({
    required this.onUpdate,
    required this.formBuilder,
  });
}

/// {adapter} class.
///
/// Defines a base behavior to handle an [EntityTable] adaption along this patter code clients from this implementations
/// can dynamically interact with the [EntityTable] instance by this adapter reference allowing to handle operations and callbacks for
/// user interactions or direct invokations.
abstract class EntityTableAdapterB<TEntity extends EntityB<TEntity>> extends ChangeNotifier {
  /// Composes the conifgurations adapted for {Deeltion} [EntityTable] behavior.
  EntityTableAdapterDeleter<TEntity>? composeDeleter() => null;

  /// Composes the conifgurations adapted for {Edition} [EntityTable] behavior.
  EntityTableAdapterEditor<TEntity>? composeEditor() => null;

  /// Composes the view details drawer at the [EntityTable].
  Widget composeViewer(BuildContext buildContext, TEntity entity);
}
