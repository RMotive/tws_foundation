import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

/// [TWSDisplayFlat] Displays an stylized text container.
class TWSDisplayFlat extends StatelessWidget {
  /// Text to display.
  final String display;

  /// Component height.
  final double? height;

  /// Component width.
  final double? width;

  /// Vertcial padding.
  final double? verticalPadding;

  /// Max component height.
  final double? maxHeight;

  /// Background Color.
  final Color? color;
  
  /// Text color.
  final Color? foreColor;

  const TWSDisplayFlat({
    super.key,
    this.width,
    this.height,
    this.maxHeight,
    this.verticalPadding,
    this.color,
    this.foreColor,
    required this.display,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManagerI<TWSFThemeBase> themeManager = Injector.getThemeManager();
    final SimpleTheming colorStruct = themeManager.get().primaryControlColor;

    Color baseColor = color ?? colorStruct.accent;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: .3),
          border: Border.fromBorderSide(
            BorderSide(
              color: baseColor,
              width: 2,
            ),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? (height != null ? 0 : 8),
              horizontal: 8,
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Text(
                  display,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: foreColor ?? colorStruct.accentAlt ?? colorStruct.fore,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
