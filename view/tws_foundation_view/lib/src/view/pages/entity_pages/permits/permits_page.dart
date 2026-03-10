import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/permits/permits_page_create_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [PermitsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class PermitsCategoryPage extends EntityCategoryPageB<Permit, PermitsEntityTableAdapter> {
  /// Creates a new [PermitsCategoryPage] instance.
  PermitsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Permits',
         routeData: FoundationRoutes.permitsPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.permitsCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => PermitsPageCreateWhisper(),
      ),
    ];
  }

  @override
  PermitsEntityTableAdapter composeAdapter() {
    return PermitsEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  List<IActionsRibbonNode> composeRibbonController(PermitsEntityTableAdapter adapter) {
     return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.permitsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(_, Color? recomdColor) {
    return Icon(
      Icons.workspace_premium_outlined,
      color: recomdColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return PermitsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [Permit] business entity to interact and manage data related with it.
final class PermitsPage extends EntityViewPageBase<Permit, PermitsEntityTableAdapter> {
  /// Creates a new [PermitsPage] instance.
  PermitsPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return PermitsEntityTable(
      adapter: adapter,
    );
  }
}
