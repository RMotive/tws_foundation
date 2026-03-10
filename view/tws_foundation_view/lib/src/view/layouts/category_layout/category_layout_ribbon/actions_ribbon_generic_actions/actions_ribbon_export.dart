import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/layouts/category_layout/category_layout_ribbon/actions_ribbon_generic_actions/_actions_ribbon_export_mobile.dart'
    if (dart.library.html) 'package:tws_foundation_view/src/view/layouts/category_layout/category_layout_ribbon/actions_ribbon_generic_actions/_actions_ribbon_export_web.dart';


/// Draws a generic {Refresh} action button for [ICategoryLayoutPage] acitons ribbon. 
final class ActionsRibbonExport<TEntity extends IEntity<TEntity>, TService extends ExportServiceI<TEntity>> extends ActionsRibbonActionBase {
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
  Icon composeIcon(Color fgColor) {
    return Icon(
      Icons.import_export,
      color: fgColor,
    );
  }
  
  @override
  FutureOr<void> perform(BuildContext context) {
    onExport?.call();
    _export();
  }
}
