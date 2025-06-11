import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/widgets/twsf_loading_circule.dart';

typedef StatesSet = Set<WidgetState>;
typedef MStates = WidgetState;

/// {widget} class.
///
/// Draws a {csm} designed button flat handling interaction and component design.
class ButtonFlat extends StatefulWidget {
  /// Control width.
  final double? width;

  /// Control height.
  final double? height;

  /// Control title.
  final String label;

  /// Flag to disable control events.
  final bool disabled;

  /// Theme scheme options.
  final SimpleTheming? theming;

  /// Trigger method on tap control for [FutureOr] functions.
  final FutureOr<void> Function()? onClick;

  /// Creates a new [ButtonFlat] instance.
  const ButtonFlat({
    super.key,
    this.width,
    this.height = 40,
    this.label = 'Hello!',
    this.disabled = false,
    this.theming,
    required this.onClick,
  });

  @override
  State<ButtonFlat> createState() => _ButtonFlatState();
}

/// {state} class.
///
/// Handles [State] for [ButtonFlat] {widget}.
final class _ButtonFlatState extends State<ButtonFlat> {
  /// {dep} theming manager dependency.
  final ThemeManagerI<FoundationThemeB> themeManager = Injector.getThemeManager();

  /// {ref} Thememing effect reference.
  final UniqueKey themingRef = UniqueKey();

  /// {state} [Widget] component theming options.
  late SimpleTheming theming;

  /// {state} Whether the component is loading data.
  bool isLoading = false;

  Color bgStateColorize(StatesSet currentStates) {
    final Color hlightColor = theming.accent;
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
    final Color hlightColor = theming.accentAlt ?? Colors.blue.shade900;
    if (widget.disabled) {
      return Colors.transparent;
    }
    return switch (currentStates) {
      (StatesSet state) when state.contains(MStates.pressed) => hlightColor,
      _ => Colors.transparent,
    };
  }

  void themeUpdateListener(FoundationThemeB theme) {
    setState(() {
      theming = theme.primControl;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.theming != null) {
      theming = widget.theming as SimpleTheming;
    } else {
      _composeTheming();
    }
  }

  @override
  void didUpdateWidget(covariant ButtonFlat oldWidget) {
    if (oldWidget.theming != widget.theming) {
      if (widget.theming != null) {
        theming = widget.theming as SimpleTheming;

        if (oldWidget.theming == null) {
          Injector.getThemeManager().removeEffect(themingRef);
        }
      } else {
        _composeTheming();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (widget.theming != null) {
      themeManager.removeEffect(themingRef);
    }
    super.dispose();
  }

  /// Composes the [theming] state initial value and subscribes to [ThemeManagerI] effect listener.
  void _composeTheming() {
    theming = Theming.get<FoundationThemeB>().page;
    themeManager.addEffect(
      themingRef,
      (FoundationThemeB theme) {
        setState(() {
          theming = theme.page;
        });
      },
    );
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
        onPressed:
            (isLoading || widget.disabled)
                ? null
                : () async {
                  if (widget.onClick == null) return;
                  setState(() => isLoading = true);
                  await widget.onClick!();
                  setState(() => isLoading = false);
                },
        child: Center(
          child: Visibility(
            visible: !isLoading,
            replacement: TwsfLoadingCircle(
              foreColor: theming.foreAlt ?? theming.fore,
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                color: theming.foreAlt ?? theming.fore,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
