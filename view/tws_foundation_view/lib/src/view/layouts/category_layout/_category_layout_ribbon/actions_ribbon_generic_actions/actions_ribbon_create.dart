import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/core/models/user_feedback.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Draws a generic {Create} action button for [CategoryLayoutPageI] acitons ribbon.
final class ActionsRisbbonCreate extends ActionsRibbonActionB {
  /// Callback invoked when the action is requested.
  final FutureOr<void> Function() onCreate;

  /// Callback invoked to validate if the action can be executed at the current context.
  final FutureOr<List<UserFeedback>> Function()? onCanExecute;

  /// Creates a new [ActionsRisbbonCreate] instance.
  const ActionsRisbbonCreate({
    required this.onCreate,
    this.onCanExecute,
  }) : super(
         title: 'Create',
         description: 'Opens an Wizard to create new data',
       );

  @override
  FutureOr<void> perform() => onCreate();

  @override
  FutureOr<List<UserFeedback>>? canExecute() {
    if (onCanExecute == null) return null;

    return onCanExecute?.call();
  }

  @override
  Icon composeIcon(Color foreColor) {
    return Icon(
      Icons.add_box_outlined,
      color: foreColor,
    );
  }
}
