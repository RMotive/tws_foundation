import 'package:csm_client/csm_client.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/widgets/entity_table/entity_table.dart';

/// {adapter} class.
///
/// Defines a
abstract class EntityTableAdapterB<TEntity extends EntityB<TEntity>> extends ChangeNotifier {
  void onRemoveRequest(TEntity set, BuildContext context);

  ///
  void Function()? onRemove() => null;

  ///
  Widget composeViewer(TEntity set, BuildContext context);

  ///
  TWSArticleTableEditor? composeEditor(TEntity set, void Function() closeReinvoke, BuildContext context);
}
