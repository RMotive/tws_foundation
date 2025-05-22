import 'package:flutter/material.dart';

///[TWSArticleTableFieldOptions] Class to set the settings and column content in [TWSArticleTable].
final class TWSArticleTableFieldOptions<T> {
  // Column header title.
  final String name;
  // Tool tip to show when the column is hovered.
  final bool tip;

  /// Header and column width.
  /// This values overrides the minWidth constraint for header and column content.
  final double? width;

  /// Column content factory.
  final String Function(T item, int index, BuildContext ctx) factory;

  const TWSArticleTableFieldOptions(
    this.name,
    this.factory, {
    this.tip = false,
    this.width,
  });
}
