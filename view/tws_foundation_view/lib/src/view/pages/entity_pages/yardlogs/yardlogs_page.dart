import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/yardlogs/create_whisper/create_yardlogs_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [YardLogsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
final class YardLogsCategoryPage extends EntityCategoryPageB<YardLog, YardLogsEntityTableAdapter> {
  /// Creates a new [YardLogsCategoryPage] instance.
  YardLogsCategoryPage({
    super.cusRoute,
    super.authBuilder,
  }) : super(
         title: 'Yard Logs',
         routeData: FoundationRoutes.yardlogsPageRoute,
       );

        @override
  List<IRoutingGraphData> composeRoutes() {
   return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.yardlogsCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => CreateYardLogsWhisper(),
      ),
    ];
  }


  @override
  YardLogsEntityTableAdapter composeAdapter() {
    return YardLogsEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  List<IActionsRibbonNode> composeRibbonController(YardLogsEntityTableAdapter adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),

      ActionsRisbbonCreate(
        onCanExecute: () async {
          final List<UserFeedback> feedbacks = <UserFeedback>[];

          SessionStorageI sessionStorage = InjectorUtils.get();
          EmployeesServiceI employeesService = InjectorUtils.get();

          String token = sessionStorage.token;

          FoundationResponseResolver<Employee?> responseResolver = await employeesService.getUserEmployee(token);

          Employee? userEmployee = responseResolver.resolveDirect(
            () => Employee(),
          );

          if (userEmployee == null) {
            UserFeedback feedback = UserFeedback();
            feedback.severity = UserFeedbackSeverities.error;
            feedback.message = 'You need to be assigned to an Employee to create a Yard Log.';
            feedbacks.add(feedback);
          }

          return feedbacks;
        },
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.yardlogsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(_, Color? recomdColor) {
    return Icon(
      Icons.yard,
      color: recomdColor,
    );
  }
  
  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return YardLogsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [YardLog] business entity to interact and manage data related with it.
final class YardLogsPage extends ViewPageBase {
  /// Inner [EntityTable] adapter.
  final YardLogsEntityTableAdapter adapter;

  /// Creates a new [YardLogsPage] instance.
  const YardLogsPage({
    required this.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return YardLogsEntityTable(
      adapter: adapter,
    );
  }
}
