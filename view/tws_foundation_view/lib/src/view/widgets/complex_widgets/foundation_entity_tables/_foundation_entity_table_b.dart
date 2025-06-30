import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {abstract} class.
///
/// Implements base behavior for {foundation} [EntityTableAdapterI] implementations.
abstract class FoundationEntityTableB<TAdapter extends EntityTableAdapterI> extends StatelessWidget {
  /// Adapter handler.
  final TAdapter adapter;

  /// Creates a new [FoundationEntityTableB] instance.
  const FoundationEntityTableB({
    super.key,
    required this.adapter,
  });
}
