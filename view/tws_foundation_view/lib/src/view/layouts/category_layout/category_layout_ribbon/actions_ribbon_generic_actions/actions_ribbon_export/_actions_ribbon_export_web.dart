import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';
import 'package:web/web.dart';

/// {web export} typedef.
typedef ActionsRibbonExportAction = ActionsRibbonExportWeb;

/// {web export} class.
/// 
/// Handles the web specific export logic for [ActionsRibbonExport].
class ActionsRibbonExportWeb {
  void export<TEntity extends EntityI<TEntity>, TService extends ExportServiceI<TEntity>>(
    ViewInput<TEntity> Function() exportView,
  ) async {
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

