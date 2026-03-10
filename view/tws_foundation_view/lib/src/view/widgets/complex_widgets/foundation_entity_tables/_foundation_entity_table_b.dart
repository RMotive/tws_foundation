import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {abstract} class.
///
/// Implements base behavior for {foundation} [IEntityTableAdapter] implementations.
abstract class FoundationEntityTableB<TEntity extends IEntity<TEntity>,TAdapter extends IEntityTableAdapter<TEntity>> extends StatelessWidget {
  /// Adapter handler.
  final TAdapter adapter;

  /// Creates a new [FoundationEntityTableB] instance.
  const FoundationEntityTableB({
    super.key,
    required this.adapter,
  });
}
