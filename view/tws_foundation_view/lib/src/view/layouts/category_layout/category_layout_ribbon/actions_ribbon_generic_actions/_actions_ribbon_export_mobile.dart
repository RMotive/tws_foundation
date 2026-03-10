import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {mobile export} typedef.
typedef ActionsRibbonExportAction = ActionsRibbonExportMobile;

/// {mobile export} class.
/// 
/// Handles the mobile specific export logic for [ActionsRibbonExport].
class ActionsRibbonExportMobile {
  void export<TEntity extends IEntity<TEntity>, TService extends ExportServiceI<TEntity>>(
    ViewInput<TEntity> Function() exportView,
  ) async {}
}


