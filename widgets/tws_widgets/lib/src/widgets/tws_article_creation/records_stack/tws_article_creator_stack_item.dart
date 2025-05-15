import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';
/// [TWSArticleCreationStackItem] Dedicated widget to resume, wrap and display the items properties in [TWSArticleCreation] widget.
final class TWSArticleCreationStackItem extends StatelessWidget {
  /// Item selection status.
  final bool selected;
  /// Properties content to show.
  final List<TwsArticleCreationStackItemProperty> properties;
  /// Layout expansion behavior flag. 
  final bool expand;
  /// Data validation status.
  final bool valid;

  const TWSArticleCreationStackItem({
    super.key,
    this.expand = false,
    this.valid = true,
    required this.properties,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManagerI<TWSFThemeBase> themeManager = Injector.getThemeManager();
    final SimpleTheming pageTheme = themeManager.get().page;
    final SimpleTheming dangerTheme = themeManager.get().primaryCriticalControl;

    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            width: valid ? 0 : 1.5,
            color: valid ? Colors.transparent : dangerTheme.accent,
          ),
        ),
      ),
      child: ColoredBox(
        color: pageTheme.fore.withAlpha(selected ? 126 : 64),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTextStyle(
            style: TextStyle(
              color: pageTheme.accentAlt ?? Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            child: IntrinsicWidth(
              child: Wrap(
                runSpacing: 10,
                children: properties,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
