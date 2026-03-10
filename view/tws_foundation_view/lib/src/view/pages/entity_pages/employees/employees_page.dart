import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/employees/create_whisper/employees_page_create_whisper.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [EmployeesPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class EmployeesCategoryPage extends EntityCategoryPageB<Employee, EmployeesEntityTableAdatper> {
  /// Creates a new [EmployeesCategoryPage] instance.
  EmployeesCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Employees',
         routeData: FoundationRoutes.employeesPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.employeesCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => EmployeesPageCreateWhisper(),
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
  List<IActionsRibbonNode> composeRibbonController(EmployeesEntityTableAdatper adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.employeesCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(BuildContext context, Color? recomdColor) {
    return Icon(
      Icons.departure_board,
      color: recomdColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return EmployeesPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [Employee] business entity to interact and manage data related with it.
final class EmployeesPage extends EntityViewPageBase<Employee, EmployeesEntityTableAdatper> {
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
