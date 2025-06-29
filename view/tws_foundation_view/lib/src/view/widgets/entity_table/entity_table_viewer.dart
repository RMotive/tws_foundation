import 'package:flutter/material.dart';

/// {widget} class.
///
/// Draws a basic default {viewer} for [EntityTable] configuring a [Column] {widget} with default properties to match along all
/// default {viewer} implementations.
final class EntityTableViewer extends StatelessWidget {
  /// Inner children to display in the viewer.
  final List<Widget> children;

  /// Creates a new [EntityTableViewer] instance.
  const EntityTableViewer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
