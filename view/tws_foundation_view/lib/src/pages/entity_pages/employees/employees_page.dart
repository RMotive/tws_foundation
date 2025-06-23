import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/pages/entity_pages/employees/employees_page_create_whisper.dart';
import 'package:tws_foundation_view/src/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [EmployeesPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
final class EmployeesCategoryPage extends EntityCategoryPageB<EmployeesEntityTableAdatper> {
  /// [EmployeesCategoryPage] inner creation {whisper} access.
  static const Route kCreateRoute = Route(
    'create',
    name: 'Employees Creation',
  );

  /// Creates a new [EmployeesCategoryPage] instance.
  EmployeesCategoryPage({
    super.cusRoute,
    required super.authBuilder,
  }) : super(
         title: 'Yard Logs',
         route: Route(
           'employees_page',
           name: 'employees',
         ),
       );

  @override
  List<RouteB> composeRoutes() {
    debugPrint('Composing Employees Category Page Routes ${kCreateRoute.hashCode}');
    return <RouteB>[
      RouteWhisper<Object>(
        kCreateRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return EmployeesPageCreateWhisper();
        },
      ),
    ];
  }

  @override
  EmployeesEntityTableAdatper composeAdapter() {
    return EmployeesEntityTableAdatper(
      authBuilder: authBuilder,
    );
  }

  @override
  CategoryLayoutRibbonControllerI composeRibbonController(EmployeesEntityTableAdatper adapter) {
    return CategoryLayoutRibbonController(
      onRefresh: adapter.refresh,
      dataManagementController: CategoryLayoutRibbonDataManagementGroupController(
        onCreate: () {
          Router router = Injector.get<Router>();

          router.go(kCreateRoute);
        },
      ),
    );
  }

  @override
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.departure_board,
      color: recomdColor,
    );
  }

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) {
    return EmployeesPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [YardLog] business entity to interact and manage data related with it.
final class EmployeesPage extends EntityPageB<EmployeesEntityTableAdatper> {
  /// Creates a new [EmployeesPage] instance.
  EmployeesPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return EmployeesEntityTable(
      adapter: adapter,
    );
  }
}
