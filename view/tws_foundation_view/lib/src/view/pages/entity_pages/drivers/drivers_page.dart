import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/drivers/create_whisper/drivers_page_create_whisper.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [DriversPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class DriversCategoryPage extends EntityCategoryPageB<DriverCommon, DriversEntityTableAdatper> {
  /// Creates a new [DriversCategoryPage] instance.
  DriversCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Drivers',
         routeData: FoundationRoutes.driversPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.driversCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => DriversPageCreateWhisper(),
      ),
    ];
  }

  @override
  DriversEntityTableAdatper composeAdapter() {
    return DriversEntityTableAdatper(
      authBuilder: authBuilder,
    );
  }

  @override
  Widget? composeIcon(_, Color? fgColor) {
    return Icon(
      Icons.departure_board,
      color: fgColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return DriversPage(
      adapter: adapter,
    );
  }
  
  @override
  List<IActionsRibbonNode> composeRibbonController(DriversEntityTableAdatper adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.driversCreateWhisperRoute);
        },
      ),
    ];
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [DriverCommon] business entity to interact and manage data related with it.
final class DriversPage extends EntityViewPageBase<DriverCommon, DriversEntityTableAdatper> {
  /// Creates a new [DriversPage] instance.
  DriversPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return DriversEntityTable(
      adapter: adapter,
    );
  }
}
