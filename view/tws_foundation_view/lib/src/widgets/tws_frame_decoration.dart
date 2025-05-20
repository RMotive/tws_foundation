import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/themes/twsf_theme_b.dart';

/// [TWSFrameDecoration] Shows an stylized frame decoration wrap for other widgets. 
final class TWSFrameDecoration extends StatelessWidget {
  /// Content widget.
  final Widget child;

  /// Upper padding.
  final double topPadding;
  
  const TWSFrameDecoration({
    super.key,
    this.topPadding = 8,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManagerI<TWSFThemeB> themeManager = Injector.getThemeManager();

    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              color: themeManager.get().page.fore,
              width: 2,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
