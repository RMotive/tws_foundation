import 'dart:async';
import 'dart:ui';

import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router, Route;
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {constant} value for [Whisper] action buttons width.
const double _actionsWidth = 125;

/// {widget} class.
///
/// Draws a {csm} design based component, this [Whisper] component
/// is a common {csm} concept for dialogs routed, so this [Widget] is used to draw a common designed
/// view.
final class Whisper extends StatefulWidget {
  /// Title
  final String title;

  /// child content to display.
  final Widget Function(GlobalKey<FormState> formState) child;

  /// {event} Callback when {close} action is called.
  final VoidCallback? onClose;

  /// {event} Callback when {perform} action is called.
  final FutureOr<void> Function()? onPerform;

  /// Creates a new [Whisper] instance.
  const Whisper({
    super.key,
    this.onClose,
    this.onPerform,
    required this.title,
    required this.child,
  });

  @override
  State<Whisper> createState() => _WhisperState();
}

/// {state} class.
///
/// Handles [State] for [Whisper].
final class _WhisperState extends State<Whisper> {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

  /// {state}
  late FoundationThemeB theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = Theming.get(context);
  }

  @override
  Widget build(BuildContext context) {
    final SimpleTheming pageTheming = theme.page;

    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.boxed();

        return ClipPath(
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.all(
                WidgetResponsiveness.clampRatio(
                  boxConstraints.maxWidth,
                  ResponsivenessRatio(
                    minValue: 10,
                    minBreak: 400,
                    maxValue: 20,
                    maxBreak: 1000,
                  ),
                ),
              ),
              child: ColoredBox(
                color: pageTheming.back,
                child: Column(
                  children: <Widget>[
                    // --> Whisper Header
                    ColoredBox(
                      color: pageTheming.accent,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 12,
                            horizontal: 18,
                          ),
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              color: pageTheming.foreAlt,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // --> Whisper Content
                    Expanded(
                      child: Form(
                        key: formStateKey,
                        child: widget.child(formStateKey),
                      ),
                    ),

                    // --> Whisper Footer
                    SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 18,
                        ),
                        child: Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            //* --> Close Action Button
                            ButtonFlat(
                              label: 'Close',
                              width: _actionsWidth,
                              theming: theme.errorTheming,
                              onClick: () {
                                Injector.get<Router>().pop();
                                widget.onClose?.call();
                              },
                            ),

                            //* --> Perform Action Button
                            if (widget.onPerform != null)
                              ButtonFlat(
                                label: 'Perform',
                                width: _actionsWidth,
                                onClick: () {
                                  if (formStateKey.currentState!.validate()) {
                                    widget.onPerform?.call();
                                  }
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
