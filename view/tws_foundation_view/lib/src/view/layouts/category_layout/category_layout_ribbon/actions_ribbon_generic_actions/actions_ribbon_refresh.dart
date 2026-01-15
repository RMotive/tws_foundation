import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Draws a generic {Refresh} action button for [CategoryLayoutPageI] acitons ribbon. 
final class ActionsRibbonRefresh extends ActionsRibbonActionB {
  /// Callback invoked when the action is requested.
  final FutureOr<void> Function() onRefresh;

  /// Creates a new [ActionsRibbonRefresh] instance.
  const ActionsRibbonRefresh({
    required this.onRefresh,
  }) : super(
         title: 'Refresh',
         description: 'Refreshes the current page data',
       );

  @override
  FutureOr<void> perform() => onRefresh();

  @override
  Icon composeIcon(Color foreColor) {
    return Icon(
      Icons.refresh_outlined,
      color: foreColor,
    );
  }
}
