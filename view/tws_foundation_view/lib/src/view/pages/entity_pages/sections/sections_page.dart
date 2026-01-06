import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/sections/create_whisper/sections_page_create_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [SectionsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class SectionsCategoryPage extends EntityCategoryPageB<LocationsEntityTableAdapter> {
  /// Creates a new [SectionsCategoryPage] instance.
  SectionsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Sections',
         route: FoundationRoutes.sectionsPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.sectionsCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return  SectionsPageCreateWhisper();
        },
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
  List<ActionsRibbonNodeI> composeRibbonController(LocationsEntityTableAdapter adapter) {
    return <ActionsRibbonNodeI>[
      ActionsRibbonRefresh(
        onRefresh: adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: () {
          Injector.get<Router>().go(FoundationRoutes.sectionsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.location_on_outlined,
      color: recomdColor,
    );
  }

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) {
    return LocationsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [Section] business entity to interact and manage data related with it.
final class SectionsPage extends EntityPageB<SectionsEntityTableAdatper> {
  /// Creates a new [SectionsPage] instance.
  SectionsPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return SectionsEntityTable(
      adapter: adapter,
    );
  }
}
