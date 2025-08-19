import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/trucks/create_whisper/trucks_page_create_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [TrucksPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class TrucksCategoryPage extends EntityCategoryPageB<TrucksEntityTableAdapter> {
  /// Creates a new [TrucksCategoryPage] instance.
  TrucksCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Trucks',
         route: FoundationRoutes.trucksPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.trucksCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return TrucksPageCreateWhisper();
        },
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
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.local_shipping,
      color: recomdColor,
    );
  }

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) {
    return TrucksPage(
      adapter: adapter,
    );
  }
  
  @override
  List<ActionsRibbonNodeI> composeRibbonController(TrucksEntityTableAdapter adapter) {
    return <ActionsRibbonNodeI>[
      ActionsRisbbonRefresh(
        onRefresh: adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: () {
          Injector.get<Router>().go(FoundationRoutes.trucksCreateWhisperRoute);
        },
      ),
    ];
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [TrucksPage] business entity to interact and manage data related with it.
final class TrucksPage extends EntityPageB<TrucksEntityTableAdapter> {
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
