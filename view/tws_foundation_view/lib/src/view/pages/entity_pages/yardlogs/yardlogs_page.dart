import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router, Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/user_feedback.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/yardlogs/create_whisper/create_yardlogs_whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [YardLogsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
final class YardLogsCategoryPage extends EntityCategoryPageB<YardLogsEntityTableAdapter> {
  /// Creates a new [YardLogsCategoryPage] instance.
  YardLogsCategoryPage({
    super.cusRoute,
    super.authBuilder,
  }) : super(
         title: 'Yard Logs',
         route: FoundationRoutes.yardlogsPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.yardlogsCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext ctx, RouteData routeData) => CreateYardLogsWhisper(),
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
  List<ActionsRibbonNodeI> composeRibbonController(YardLogsEntityTableAdapter adapter) {
    return <ActionsRibbonNodeI>[
      ActionsRisbbonRefresh(
        onRefresh: adapter.refresh,
      ),

      ActionsRisbbonCreate(
        onCanExecute: () async {
          final List<UserFeedback> feedback = <UserFeedback>[];

          SessionStorageI sessionStorage = Injector.get();
          EmployeesServiceI employeesService = Injector.get();

          String token = sessionStorage.token;

          FoundationResponseResolver<Employee?> responseResolver = await employeesService.getUserEmployee(token);

          Employee? userEmployee = responseResolver.resolveDirect(
            () => Employee(),
          );

          if (userEmployee == null) {
            feedback.add(
              UserFeedback(
                type: UserFeedbackType.error,
                message: 'You need an Employee assigned to create a Yard Log.',
              ),
            );
          }

          return feedback;
        },
        onCreate: () {
          Injector.get<Router>().go(FoundationRoutes.yardlogsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.yard,
      color: recomdColor,
    );
  }

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) {
    return YardLogsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [YardLog] business entity to interact and manage data related with it.
final class YardLogsPage extends PageB {
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
