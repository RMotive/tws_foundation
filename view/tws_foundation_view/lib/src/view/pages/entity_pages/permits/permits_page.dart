import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/permits/permits_page_create_whisper.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/permits_entity_table.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [PermitsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class PermitsCategoryPage extends EntityCategoryPageB<PermitsEntityTableAdapter> {
  /// Creates a new [PermitsCategoryPage] instance.
  PermitsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Permits',
         route: FoundationRoutes.permitsPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.permitsCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return PermitsPageCreateWhisper();
        },
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
  List<ActionsRibbonNodeI> composeRibbonController(PermitsEntityTableAdapter adapter) {
     return <ActionsRibbonNodeI>[
      ActionsRisbbonRefresh(
        onRefresh: adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: () {
          Injector.get<Router>().go(FoundationRoutes.permitsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.workspace_premium_outlined,
      color: recomdColor,
    );
  }

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) {
    return PermitsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [Permit] business entity to interact and manage data related with it.
final class PermitsPage extends EntityPageB<PermitsEntityTableAdapter> {
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
