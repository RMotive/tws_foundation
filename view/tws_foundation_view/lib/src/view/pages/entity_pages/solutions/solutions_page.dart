import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/solutions/solutions_page_create_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [SectionsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class SolutionsCategoryPage extends EntityCategoryPageB<SolutionsEntityTableAdapter> {
  /// Creates a new [SolutionsCategoryPage] instance.
  SolutionsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Solutions',
         route: FoundationRoutes.solutionsPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.solutionsCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return SolutionsPageCreateWhisper();
        },
      ),
    ];
  }

  @override
  SolutionsEntityTableAdapter composeAdapter() {
    return SolutionsEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  List<ActionsRibbonNodeI> composeRibbonController(SolutionsEntityTableAdapter adapter) {
    return <ActionsRibbonNodeI>[
      ActionsRibbonRefresh(
        onRefresh: adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: () {
          Injector.get<Router>().go(FoundationRoutes.solutionsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.account_tree_outlined,
      color: recomdColor,
    );
  }

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) {
    return SolutionsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [Solution] business entity to interact and manage data related with it.
final class SolutionsPage extends EntityPageB<SolutionsEntityTableAdapter> {
  /// Creates a new [SolutionsPage] instance.
  SolutionsPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return SolutionsEntityTable(
      adapter: adapter,
    );
  }
}
