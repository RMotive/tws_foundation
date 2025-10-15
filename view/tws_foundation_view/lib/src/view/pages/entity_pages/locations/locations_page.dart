import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/employees/employees_page_create_whisper.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/locations_entity_table.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [EmployeesPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class LocationsCategoryPage extends EntityCategoryPageB<LocationsEntityTableAdatper> {
  /// Creates a new [LocationsCategoryPage] instance.
  LocationsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Locations',
         route: FoundationRoutes.locationsPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.locationsCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return EmployeesPageCreateWhisper();
        },
      ),
    ];
  }

  @override
  LocationsEntityTableAdatper composeAdapter() {
    return LocationsEntityTableAdatper(
      authBuilder: authBuilder,
    );
  }

  @override
  List<ActionsRibbonNodeI> composeRibbonController(LocationsEntityTableAdatper adapter) {
    return <ActionsRibbonNodeI>[];
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
    return LocationsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [YardLog] business entity to interact and manage data related with it.
final class LocationsPage extends EntityPageB<LocationsEntityTableAdatper> {
  /// Creates a new [LocationsPage] instance.
  LocationsPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return LocationsPage(
      adapter: adapter,
    );
  }
}
