import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Draws a generic {Refresh} action button for [CategoryLayoutPageI] acitons ribbon. 
final class ActionsRibbonExport extends ActionsRibbonActionB {
  /// Callback invoked when the action is requested.
  final FutureOr<void> Function() onExport;

  /// Creates a new [ActionsRibbonExport] instance.
  const ActionsRibbonExport({
    required this.onExport,
  }) : super(
         title: 'Export view',
         description: 'Download the current page data',
       );

  @override
  FutureOr<void> perform() => onExport();

  @override
  Icon composeIcon(Color foreColor) {
    return Icon(
      Icons.import_export,
      color: foreColor,
    );
  }
}
