import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/employees/employees_page_create_whisper.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [EmployeesPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class EmployeesCategoryPage extends EntityCategoryPageB<EmployeesEntityTableAdatper> {
  /// Creates a new [EmployeesCategoryPage] instance.
  EmployeesCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Employees',
         route: FoundationRoutes.employeesPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.employeesCreateWhisperRoute,
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

          router.go(FoundationRoutes.employeesCreateWhisperRoute);
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
