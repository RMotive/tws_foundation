import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/trucks/create_whisper/trucks_page_create_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [TrucksPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class TrucksCategoryPage extends EntityCategoryPageB<TruckCommon, TrucksEntityTableAdapter> {
  /// Creates a new [TrucksCategoryPage] instance.
  TrucksCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Trucks',
         routeData: FoundationRoutes.trucksPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.trucksCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => TrucksPageCreateWhisper(),
      ),
    ];
  }

  @override
  TrucksEntityTableAdapter composeAdapter() {
    return TrucksEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  Widget? composeIcon(_, Color? fgColor) {
    return Icon(
      Icons.local_shipping,
      color: fgColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return TrucksPage(
      adapter: adapter,
    );
  }
  
  @override
  List<IActionsRibbonAction> composeRibbonController(TrucksEntityTableAdapter adapter) {
    return <IActionsRibbonAction>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.trucksCreateWhisperRoute);
        },
      ),
    ];
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [TrucksPage] business entity to interact and manage data related with it.
final class TrucksPage extends EntityViewPageBase<TruckCommon, TrucksEntityTableAdapter> {
  /// Creates a new [TrucksPage] instance.
  TrucksPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return TrucksEntityTable(
      adapter: adapter,
    );
  }
}
