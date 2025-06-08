import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';

/// {widget} class.
///
/// Draws a {CSM} visual design pattern for a bordered box.
final class BorderedBox extends StatelessWidget {
  /// Wrapped widget bordered box.
  final Widget child;

  /// Content [child] padding.
  final EdgeInsets padding;

  /// Creates a new [BorderedBox] instance.
  const BorderedBox({
    super.key,
    this.padding = const EdgeInsets.only(
      top: 8,
    ),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final SimpleTheming pageTheme = Theming.get<FoundationThemeB>().page;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: pageTheme.fore,
            width: .75,
          ),
        ),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
