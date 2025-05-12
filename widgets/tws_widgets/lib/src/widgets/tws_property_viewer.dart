
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';
/// [TWSPropertyViewer] Shows a text format for properties: Property title and the property value.
final class TWSPropertyViewer extends StatelessWidget {
  /// Property name.
  final String label;
  
  /// Property value.
  final String? value;

  const TWSPropertyViewer({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManager<TWSFThemeBase> themeManager = Injector.get();
    final SimpleTheming pageTheme = themeManager.get().page;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        Text(
          '$label:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: pageTheme.fore
          ),
        ),
        Text(
          value ?? '---',
          style: TextStyle(
            color: pageTheme.fore
          ),
        ),
      ],
    );
  }
}
