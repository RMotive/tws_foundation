import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/trailers/create_whisper/trailers_page_create_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [TrailersPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class TrailersCategoryPage extends EntityCategoryPageB<TrailersEntityTableAdapter> {
  /// Creates a new [TrailersCategoryPage] instance.
  TrailersCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Trailers',
         route: FoundationRoutes.trailersPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.trailersCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return TrailersPageCreateWhisper();
        },
      ),
    ];
  }

  @override
  TrailersEntityTableAdapter composeAdapter() {
    return TrailersEntityTableAdapter(
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
    return TrailersPage(
      adapter: adapter,
    );
  }
  
  @override
  List<ActionsRibbonNodeI> composeRibbonController(TrailersEntityTableAdapter adapter) {
    return <ActionsRibbonNodeI>[
      ActionsRisbbonRefresh(
        onRefresh: adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: () {
          Injector.get<Router>().go(FoundationRoutes.trailersCreateWhisperRoute);
        },
      ),
    ];
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [TrailersPage] business entity to interact and manage data related with it.
final class TrailersPage extends EntityPageB<TrailersEntityTableAdapter> {
  /// Creates a new [TrucksPage] instance.
  TrailersPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return TrailersEntityTable(
      adapter: adapter,
    );
  }
}
