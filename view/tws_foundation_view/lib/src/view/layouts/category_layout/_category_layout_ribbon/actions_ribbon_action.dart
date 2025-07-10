import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/core/models/user_feedback.dart';
import 'package:tws_foundation_view/src/view/widgets/loading_widget.dart';
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
  Icon composeIcon(Color foreColor);

  /// Validates if can be executed, if not will be displayed as disabled but when user clicks on it will display [messageBus] information.
  FutureOr<List<UserFeedback>>? canExecute();

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
  Icon composeIcon(Color foreColor) {
    return Icon(
      Icons.check_box_outline_blank_outlined,
      color: foreColor,
    );
  }

  @override
  FutureOr<List<UserFeedback>>? canExecute() => null;

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
  final Icon Function(Color foreColor)? iconBuilder;

  /// Callback function triggered on action context building that determines if the
  /// action can be executed if {false} will disable it.
  ///
  ///
  /// [messageBus] collection [String] reference to store all user feedback messages about why the action can't be executed.
  final FutureOr<List<UserFeedback>> Function()? onCanExecute;

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
  Icon composeIcon(Color foreColor) {
    if (iconBuilder == null) {
      return super.composeIcon(foreColor);
    }

    return iconBuilder!.call(foreColor);
  }

  @override
  FutureOr<List<UserFeedback>>? canExecute() {
    if (onCanExecute == null) return null;

    return onCanExecute?.call();
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
  /// {state} application theme data.
  late FoundationThemeB themeData = Theming.get<FoundationThemeB>(context);

  /// [Widget] current state.
  CSMStates state = CSMStates.none;

  /// {state} whether the current [Widget] is waiting to finish invokation.
  bool isLoading = false;

  /// {state} whether the current [evaluateExecution] result says if the button can be executed or not.
  bool canExecute = true;

  @override
  void initState() {
    super.initState();

    evaluateExecution();
  }

  @override
  void didChangeDependencies() {
    themeData = Theming.get<FoundationThemeB>(context);
    super.didChangeDependencies();
  }

  /// {event} Triggered when the user mouse pointer clicks on the button.
  void onClick() async {
    if ((await evaluateExecution()).isNotEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
      state = CSMStates.selected;
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
    });
  }

  /// Evaluates if the current [_ActionButton] can be executed by the user.
  Future<List<UserFeedback>> evaluateExecution() async {
    setState(() {
      isLoading = true;
    });
    FutureOr<List<UserFeedback>>? invokation = widget.actionData.canExecute();

    if (invokation == null) {
      setState(() {
        isLoading = false;
      });
      return <UserFeedback>[];
    }

    List<UserFeedback> canExecuteResult = await invokation;
    if (canExecuteResult.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return <UserFeedback>[];
    }

    setState(() {
      canExecute = false;
      isLoading = false;
    });

    return canExecuteResult;
  }

  @override
  Widget build(BuildContext context) {
    ComplexTheming stateTheme = state.evaluateTheme(themeData.categoryLayoutRibbonButton);

    Color back = canExecute ? stateTheme.background! : themeData.disabled.back;
    if (!canExecute && state == CSMStates.hovered) {
      back = back.withValues(
        alpha: .7,
      );
    }

    Color fore = canExecute ? stateTheme.foreground! : themeData.disabled.fore;

    return PointerArea(
      cursor: isLoading ? MouseCursor.defer : SystemMouseCursors.click,
      onClick: isLoading ? null : onClick,
      onHover: isLoading ? null : onHover,
      child: ColoredBox(
        color: back,
        child: SizedBox.fromSize(
          size: Size.square(75),
          child: Visibility(
            visible: !isLoading,
            replacement: LoadingWidget(
              fit: BoxFit.fitHeight,
              foreColor: stateTheme.foreground!,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              child: Column(
                spacing: 8,
                children: <Widget>[
                  /// ---> Icon Builder
                  IconTheme(
                    data: IconThemeData(
                      size: 28,
                    ),
                    child: widget.actionData.composeIcon(fore),
                  ),

                  /// --> Action title.
                  Text(
                    widget.actionData.title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13,
                      color: fore,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
