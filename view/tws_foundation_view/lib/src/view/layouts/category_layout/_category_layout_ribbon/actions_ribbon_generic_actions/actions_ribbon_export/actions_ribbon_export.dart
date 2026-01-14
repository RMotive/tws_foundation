import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

// ignore: always_use_package_imports
import 'actions_ribbon_export_mobile.dart' if(dart.library.html) 'actions_ribbon_export_web.dart';


/// Draws a generic {Refresh} action button for [CategoryLayoutPageI] acitons ribbon. 
final class ActionsRibbonExport<TEntity extends EntityI<TEntity>, TService extends ExportServiceI<TEntity>> extends ActionsRibbonActionB {
  /// Callback invoked when the action is requested.
  final FutureOr<void> Function()? onExport;

  /// Callback invoked to get the consumed view input to export.
  final ViewInput<TEntity> Function() exportView;

  /// Creates a new [ActionsRibbonExport] instance.
  const ActionsRibbonExport({
    required this.exportView,
    this.onExport,
  }) : super(
         title: 'Export',
         description: 'Download the current page data',
       );

  Future<void> _export() async {
     ActionsRibbonExportAction().export<TEntity, TService>(exportView);
  }

  @override
  FutureOr<void> perform() {
    onExport?.call();
    _export();
    
  }

  @override
  Icon composeIcon(Color foreColor) {
    return Icon(
      Icons.import_export,
      color: foreColor,
    );
  }
}
