import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

typedef StatesSet = Set<WidgetState>;
typedef MStates = WidgetState;

class TWSButtonFlat<T extends TWSFThemeBase> extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final bool waiting;
  final bool disabled;
  final T? theme;
  final Function() onTap;

  const TWSButtonFlat({
    super.key,
    this.width,
    this.theme,
    this.height = 40,
    this.label = 'Hello!',
    this.waiting = false,
    this.disabled = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final CSMColorThemeOptions colorStruct = theme?.primaryControlColor ?? TWSFDarkTheme().primaryControlColor;

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
                  color: colorStruct.foreAlt,
                ),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: colorStruct.foreAlt,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
