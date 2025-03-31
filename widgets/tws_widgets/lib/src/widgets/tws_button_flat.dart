import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/src/widgets/twsf_loading_circule.dart';
import 'package:tws_widgets/tws_widgets.dart';

typedef StatesSet = Set<WidgetState>;
typedef MStates = WidgetState;

/// [TWSButtonFlat] Simple TWS Custom control button with async capabilities.
class TWSButtonFlat extends StatefulWidget {
  /// Control width.
  final double? width;

  /// Control height.
  final double? height;

  /// Control title.
  final String label;
  
  /// Flag to disable control events.
  final bool disabled;

  /// Theme scheme options.
  final CSMColorThemeOptions? themeOptions;

  /// Trigger method on tap control for [FutureOr] functions.
  final FutureOr<void> Function()? onTap;

  const TWSButtonFlat({
    super.key,
    this.width,
    this.height = 40,
    this.label = 'Hello!',
    this.disabled = false,
    this.themeOptions,
    required this.onTap,
  });

  @override
  State<TWSButtonFlat> createState() => _TWSButtonFlatState();
}

class _TWSButtonFlatState extends State<TWSButtonFlat> {
  late bool waiting;
  late TWSFThemeBase theme;
  late CSMColorThemeOptions colorStruct;
  
  Color bgStateColorize(StatesSet currentStates) {
    final Color hlightColor = colorStruct.highlight;
    final Color reducedColor = hlightColor.withValues(alpha: .7);
    if (widget.disabled) {
      return reducedColor.withValues(alpha: .3);
    }

    return switch (currentStates) {
      (StatesSet state) when state.contains(MStates.hovered) => hlightColor,
      _ => reducedColor,
    };
  }

  Color olStateColorize(StatesSet currentStates) {
    final Color hlightColor = colorStruct.hightlightAlt ?? Colors.blue.shade900;
    if (widget.disabled) {
      return Colors.transparent;
    }
    return switch (currentStates) {
      (StatesSet state) when state.contains(MStates.pressed) => hlightColor,
      _ => Colors.transparent,
    };
  }

  void themeUpdateListener() {
    setState(() {
      theme = getTheme();
    });
  }

  @override
  void initState() {
    super.initState();
    waiting = false;
    theme = getTheme(
      updateEfect: themeUpdateListener,
    );
    colorStruct = theme.primaryControlColor;
  }

  @override
  void dispose() {
    disposeEffect(themeUpdateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextButton(
        style: ButtonStyle(
          enableFeedback: true,
          backgroundColor: WidgetStateColor.resolveWith(bgStateColorize),
          overlayColor: WidgetStateColor.resolveWith(olStateColorize),
          shape: WidgetStateProperty.all(const LinearBorder()),
        ),
        onPressed: (waiting || widget.disabled) ? null : () async {
          if(widget.onTap == null) return;
          setState(() => waiting = true);
          await widget.onTap!();
          setState(() => waiting = false);
        },
        child: Center(
          child: Visibility(
            visible: !waiting,
            replacement: TwsfLoadingCircle(
              foreColor: colorStruct.foreAlt ?? colorStruct.fore,
            ),
            child: Text(
              widget.label,
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