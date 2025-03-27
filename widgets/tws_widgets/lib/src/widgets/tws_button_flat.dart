import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

typedef StatesSet = Set<WidgetState>;
typedef MStates = WidgetState;

/// [TWSButtonFlat] Simple TWS Custom control button with async capabilities.
class TWSButtonFlat extends StatelessWidget {
  /// Control width.
  final double? width;

  /// Control height.
  final double? height;

  /// Control title.
  final String label;

  /// If this values is true, shows a loading component.
  /// 
  /// When is set to false, shows the control button.
  final bool waiting;
  
  /// Flag to disable control events.
  final bool disabled;

  /// Theme scheme options.
  final CSMColorThemeOptions? themeOptions;

  /// Trigger method on tap control.
  final Function() onTap;

  const TWSButtonFlat({
    super.key,
    this.width,
    this.height = 40,
    this.label = 'Hello!',
    this.waiting = false,
    this.disabled = false,
    this.themeOptions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final CSMColorThemeOptions colorStruct =
        themeOptions ?? getTheme<TWSFThemeBase>().primaryControlColor;

    Color bgStateColorize(StatesSet currentStates) {
      final Color hlightColor = colorStruct.highlight;
      final Color reducedColor = hlightColor.withValues(alpha: .7);
      if (disabled) {
        return reducedColor.withValues(alpha: .3);
      }

      return switch (currentStates) {
        (StatesSet state) when state.contains(MStates.hovered) => hlightColor,
        _ => reducedColor,
      };
    }

    Color olStateColorize(StatesSet currentStates) {
      final Color hlightColor = colorStruct.hightlightAlt ?? Colors.blue.shade900;
      if (disabled) {
        return Colors.transparent;
      }
      return switch (currentStates) {
        (StatesSet state) when state.contains(MStates.pressed) => hlightColor,
        _ => Colors.transparent,
      };
    }

    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          enableFeedback: true,
          backgroundColor: WidgetStateColor.resolveWith(bgStateColorize),
          overlayColor: WidgetStateColor.resolveWith(olStateColorize),
          shape: WidgetStateProperty.all(const LinearBorder()),
        ),
        onPressed: (waiting || disabled) ? null : onTap,
        child: Center(
          child: Visibility(
            visible: !waiting,
            replacement: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.transparent,
                  color: colorStruct.fore,
                ),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: colorStruct.foreAlt ?? colorStruct.fore,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
