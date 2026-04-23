import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [TrailersInventoryPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
final class TrailersInventoryCategoryPage extends EntityCategoryPageB<YardLog, TrailersInventoryEntityTableAdapter> {
  /// Creates a new [TrailersInventoryCategoryPage] instance.
  TrailersInventoryCategoryPage({
    super.cusRoute,
    super.authBuilder,
  }) : super(
         title: 'Trailer Inventory',
         routeData: FoundationRoutes.trailerInventoryPageRoute,
       );

       @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      
    ];
  }

  @override
  TrailersInventoryEntityTableAdapter composeAdapter() {
    return TrailersInventoryEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  List<IActionsRibbonNode> composeRibbonController(TrailersInventoryEntityTableAdapter adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh(),
      ),
    ];
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return TrailersInventoryPage(
      adapter: adapter,
    );
  }
  
  @override
  Widget? composeIcon(BuildContext context, Color? fgColor) {
    return Icon(
      Icons.inventory,
      color: fgColor,
    );
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [YardLog] business entity to interact and manage data related with it.
final class TrailersInventoryPage extends ViewPageBase {
  /// Inner [EntityTable] adapter.
  final TrailersInventoryEntityTableAdapter adapter;

  /// Creates a new [TrailersInventoryPage] instance.
  const TrailersInventoryPage({
    required this.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return TrailerInventoryEntityTable(
      adapter: adapter,
    );
  }
}
