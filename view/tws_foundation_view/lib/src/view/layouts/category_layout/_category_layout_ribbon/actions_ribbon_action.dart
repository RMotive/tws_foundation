import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Represents the actions ribbon action properties contract, that represents an actions ribbon action button to
/// perform an operation.
abstract interface class ActionsRibbonActionI implements ActionsRibbonNodeI {
  /// Action title.
  final String title;

  /// Action description.
  final String? description;

  /// Creates a new [ActionsRibbonActionI] instance.
  const ActionsRibbonActionI(
    this.title,
    this.description,
  );

  /// Composes the [Icon] to display for this [ActionsRibbonActionI].
  ///
  ///
  /// [foreColor] current theme data recommended fore color.
  FutureOr<Icon> composeIcon(Color foreColor);

  /// Validates if can be executed, if not will be displayed as disabled but when user clicks on it will display [messageBus] information.
  ///
  /// [messageBus] a [String] collection reference to push context information for the engine to display when the action can't be executed and why not.
  FutureOr<bool>? canExecute(List<String> messageBus);

  /// Performs the [ActionsRibbonActionI] implementation functionality when the button [canExecute].
  FutureOr<void> perform();
}

/// Handles base [ActionsRibbonActionI] behavior allowing simplified extensions.
abstract class ActionsRibbonActionB implements ActionsRibbonActionI {
  /// Action title.
  @override
  final String title;

  /// Action description.
  @override
  final String? description;

  /// Creates a new [ActionsRibbonActionB] instance.
  const ActionsRibbonActionB({
    required this.title,
    this.description,
  });

  @override
  FutureOr<Icon> composeIcon(Color foreColor) {
    return Icon(
      Icons.check_box_outline_blank_outlined,
      color: foreColor,
    );
  }

  @override
  FutureOr<bool>? canExecute(List<String> messageBus) => null;

  @override
  Widget compose() {
    return _ActionButton(
      actionData: this,
    );
  }
}

/// Represents an action button to be rendered along [CategoryLayoutPageI] actions ribbon.
final class ActionsRibbonAction extends ActionsRibbonActionB {
  /// Callback invoked when action is requested.
  final FutureOr<void> Function() onPerform;

  /// Builder invokation to compose the button [Icon] decorator.
  ///
  ///
  /// [foreColor] engine handled recommended icon color.
  final FutureOr<Icon> Function(Color foreColor)? iconBuilder;

  /// Callback function triggered on action context building that determines if the
  /// action can be executed if {false} will disable it.
  ///
  ///
  /// [messageBus] collection [String] reference to store all user feedback messages about why the action can't be executed.
  final FutureOr<bool> Function(List<String> messageBus)? onCanExecute;

  /// Creates a new [ActionsRibbonActionI] instance.
  const ActionsRibbonAction({
    required super.title,
    required this.onPerform,
    this.iconBuilder,
    this.onCanExecute,
  });

  @override
  FutureOr<void> perform() => onPerform;

  @override
  FutureOr<Icon> composeIcon(Color foreColor) {
    if (iconBuilder == null) {
      return super.composeIcon(foreColor);
    }

    return iconBuilder!.call(foreColor);
  }

  @override
  FutureOr<bool>? canExecute(List<String> messageBus) {
    if (onCanExecute == null) return null;

    return onCanExecute?.call(messageBus);
  }

  @override
  Widget compose() {
    return SizedBox();
  }
}

/// Draws a complex [CategoryLayout] actions ribbon action button and its behavior.
final class _ActionButton extends StatefulWidget {
  /// Action data.
  final ActionsRibbonActionI actionData;

  /// Creates a new [_ActionButton] instance.
  const _ActionButton({
    required this.actionData,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

/// {state} class.
///
/// Implements [State] handling for [_CategoryLayoutRibbonArticleButton].
final class _ActionButtonState extends State<_ActionButton> {
  /// {state} current icon builder.
  late FutureOr<Icon> iconBuilder;

  /// [Widget] scoped theme data.
  late StateTheming stateTheming = Theming.get<FoundationThemeB>(context).categoryLayoutRibbonButton;

  /// [Widget] current [state] theme data.
  late ComplexTheming themeData;

  /// [Widget] current state.
  CSMStates state = CSMStates.none;

  /// Whether the current [Widget] is waiting to finish invokation.
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    evaluateThemeData();
  }

  @override
  void didChangeDependencies() {
    stateTheming = Theming.get<FoundationThemeB>(context).categoryLayoutRibbonButton;
    super.didChangeDependencies();
  }

  /// {event} Triggered when the user mouse pointer clicks on the button.
  void onClick() async {
    setState(() {
      isLoading = true;
      state = CSMStates.selected;
      evaluateThemeData();
    });

    await widget.actionData.perform();

    setState(() {
      isLoading = false;
    });
  }

  /// {event} Triggered when the user mouse pointer is in / out button pointer area.
  void onHover(bool $in) {
    setState(() {
      state = $in ? CSMStates.hovered : CSMStates.none;
      evaluateThemeData();
    });
  }

  void evaluateThemeData() {
    setState(() {
      themeData = state.evaluateTheme(stateTheming);
      iconBuilder = widget.actionData.composeIcon(themeData.foreground!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.actionData.description ?? '',
      child: PointerArea(
        cursor: isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
        onClick: isLoading ? null : onClick,
        onHover: isLoading ? null : onHover,
        child: AspectRatio(
          aspectRatio: 1,
          child: ColoredBox(
            color: themeData.background!,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Visibility(
                visible: !isLoading,
                child: Column(
                  spacing: 1,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /// --> Action Button Icon
                    AsyncWidget<Icon>(
                      future: iconBuilder,
                      successBuilder: (BuildContext ctx, Icon data) {
                        return data;
                      },
                    ),

                    /// --> Action Button title
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        widget.actionData.title,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                          color: themeData.foreground,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                replacement: Transform.scale(
                  scale: .5,
                  child: CircularProgressIndicator(
                    color: themeData.foreground?.withValues(
                      alpha: .7,
                    ),
                    strokeWidth: 3,
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
