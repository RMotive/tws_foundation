import 'dart:async';
import 'dart:convert';
import 'dart:js_interop' if(dart.library.io) '';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';
import 'package:web/web.dart' if (dart.library.io) '';

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

    if(kIsWeb){
      /// Getting services.
      TService service = Injector.get();
      SessionStorageI sessionStorage = Injector.get();
      String token = sessionStorage.token;

      /// Consuming the view to export.
      FoundationResponseResolver<ExportOutput> resolver = await service.exportView(exportView(), token);
      ExportOutput exportOutput  = resolver.resolveDirect(
        () => ExportOutput(),
      );

      /// Preparing the download configuration.
      Uint8List bytes = base64Decode(exportOutput.content);
      final JSArrayBuffer parts = Uint8List.fromList(bytes).buffer.toJS;
      final Blob blob = Blob(<JSArrayBuffer>[parts].toJS, BlobPropertyBag(type:'application/xmls'));
      final String url = URL.createObjectURL(blob);
      final HTMLAnchorElement anchor = HTMLAnchorElement();
      anchor.href =  url;
      anchor.download = '${exportOutput.name}.${exportOutput.extension.name}';
      // anchor.setAttribute('download', '${exportOut.name}.${exportOut.extension.value}');
      anchor.click();

      URL.revokeObjectURL(url);
    }
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
