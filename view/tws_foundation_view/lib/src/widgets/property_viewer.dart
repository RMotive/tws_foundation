import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} class.
///
/// Draws a {CSM} design property viewer to easely display a property name and its context value friendly to the user.
final class PropertyViewer extends StatelessWidget {
  /// Property name.
  final String label;

  /// Property value.
  final String? value;

  const PropertyViewer({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final SimpleTheming pageTheme = Theming.get<FoundationThemeB>(context).page;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        Text(
          '$label:',
          style: TextStyle(fontWeight: FontWeight.w600, color: pageTheme.fore),
        ),
        Text(value ?? '---', style: TextStyle(color: pageTheme.fore)),
      ],
    );
  }
}
