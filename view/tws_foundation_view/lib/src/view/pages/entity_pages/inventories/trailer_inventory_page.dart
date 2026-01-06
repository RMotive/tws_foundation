import 'dart:typed_data';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router, Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/layouts/category_layout/_category_layout_ribbon/actions_ribbon_generic_actions/actions_ribbon_export.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/trailers_inventory_entity_table.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';
import 'package:web/web.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [TrailersInventoryPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
final class TrailersInventoryCategoryPage extends EntityCategoryPageB<TrailersInventoryEntityTableAdapter> {
  /// Creates a new [TrailersInventoryCategoryPage] instance.
  TrailersInventoryCategoryPage({
    super.cusRoute,
    super.authBuilder,
  }) : super(
         title: 'Trailer Inventory',
         route: FoundationRoutes.trailerInventoryPageRoute,
       );

  @override
  TrailersInventoryEntityTableAdapter composeAdapter() {
    return TrailersInventoryEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  List<ActionsRibbonNodeI> composeRibbonController(TrailersInventoryEntityTableAdapter adapter) {
    return <ActionsRibbonNodeI>[
      ActionsRibbonRefresh(
        onRefresh: adapter.refresh,
      ),
      ActionsRibbonExport(
        onExport: () async {

            MainResolver<ExportOut> resolver = await twsFoundation.yardLogs.exportInventory(inventoryViewOptions!, _sessionStorage.getTokenStrict());
            ExportOut exportOut = await resolver.act(ExportOut.des);
            final Blob blob = Blob(<Uint8List>[exportOut.content]);
            final String url = Url.createObjectUrlFromBlob(blob);
            final AnchorElement anchor = AnchorElement(href: url);
            anchor.setAttribute('download', '${exportOut.name}.${exportOut.extension.value}');
            anchor.click();

            Url.revokeObjectUrl(url);
        },
      )
    ];
  }

  @override
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.inventory,
      color: recomdColor,
    );
  }

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) {
    return TrailersInventoryPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [YardLog] business entity to interact and manage data related with it.
final class TrailersInventoryPage extends PageB {
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
