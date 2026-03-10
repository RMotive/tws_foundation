import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/locations/create_whisper/locations_page_create_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [LocationsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class LocationsCategoryPage extends EntityCategoryPageB<Location, LocationsEntityTableAdapter> {
  /// Creates a new [LocationsCategoryPage] instance.
  LocationsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Locations',
         routeData: FoundationRoutes.locationsPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.locationsCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => LocationsPageCreateWhisper(),
      ),
    ];
  }

  @override
  LocationsEntityTableAdapter composeAdapter() {
    return LocationsEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  List<IActionsRibbonNode> composeRibbonController(LocationsEntityTableAdapter adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.locationsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(BuildContext context, Color? fgColor) {
    return Icon(
      Icons.location_on_outlined,
      color: fgColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return LocationsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [Location] business entity to interact and manage data related with it.
final class LocationsPage extends EntityViewPageBase<Location, LocationsEntityTableAdapter> {
  /// Creates a new [LocationsPage] instance.
  LocationsPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return LocationsEntityTable(
      adapter: adapter,
    );
  }
}
