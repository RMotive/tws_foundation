import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/solutions/solutions_page_create_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [SectionsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class SolutionsCategoryPage extends EntityCategoryPageB<Solution, SolutionsEntityTableAdapter> {
  /// Creates a new [SolutionsCategoryPage] instance.
  SolutionsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Solutions',
         routeData: FoundationRoutes.solutionsPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.solutionsCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => SolutionsPageCreateWhisper(),
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
  List<IActionsRibbonNode> composeRibbonController(SolutionsEntityTableAdapter adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.solutionsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(_, Color? recomdColor) {
    return Icon(
      Icons.account_tree_outlined,
      color: recomdColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return SolutionsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [Solution] business entity to interact and manage data related with it.
final class SolutionsPage extends EntityViewPageBase<Solution, SolutionsEntityTableAdapter> {
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
