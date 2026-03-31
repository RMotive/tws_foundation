import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/yardlogs/yardlogs_reservations/create_yardlogs_reservations_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [YardLogsPage] category page for reservations implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
/// 
/// This page is intended to show only the not finalized reservations.
/// Only Gatekeepers and admins users can access this page, and only if they are assigned to an Employee at the system.
/// Gatekeepers will be able to set a reservation as finalized, filling the corresponding yardlog creation form with the reservation data.
final class YardLogsReservationsCategoryPage extends EntityCategoryPageB<YardLog, YardLogsEntityTableAdapter> {
  /// Creates a new [YardLogsReservationsCategoryPage] instance.
  YardLogsReservationsCategoryPage({
    super.cusRoute,
    super.authBuilder,
  }) : super(
         title: 'Yard Reservations',
         routeData: FoundationRoutes.yardlogsReservationsPageRoute,
       );

        @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.yardlogsReservationsCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => CreateYardLogsReservationsWhisper(adapter: adapter),
      ),
    ];
  }


  @override
  YardLogsEntityTableAdapter composeAdapter() {
    return YardLogsEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  List<IActionsRibbonNode> composeRibbonController(YardLogsEntityTableAdapter adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
    ];
  }

  @override
  Widget? composeIcon(_, Color? recomdColor) {
    return Icon(
      Icons.yard,
      color: recomdColor,
    );
  }
  
  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return YardLogsReservationsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [YardLog] business entity to interact and manage data related with it.
final class YardLogsReservationsPage extends ViewPageBase {
  /// Inner [EntityTable] adapter.
  final YardLogsEntityTableAdapter adapter;

  /// Creates a new [YardLogsReservationsPage] instance.
  const YardLogsReservationsPage({
    required this.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return YardLogsEntityTable(
      adapter: adapter,
    );
  }
}
