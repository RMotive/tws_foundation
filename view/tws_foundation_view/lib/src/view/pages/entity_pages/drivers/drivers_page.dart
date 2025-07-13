import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/drivers/create_whisper/drivers_page_create_whisper.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [DriversPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class DriversCategoryPage extends EntityCategoryPageB<DriversEntityTableAdatper> {
  /// Creates a new [DriversCategoryPage] instance.
  DriversCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Drivers',
         route: FoundationRoutes.driversPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.driversCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return DriversPageCreateWhisper();
        },
      ),
    ];
  }

  @override
  DriversEntityTableAdatper composeAdapter() {
    return DriversEntityTableAdatper(
      authBuilder: authBuilder,
    );
  }

  @override
  CategoryLayoutRibbonControllerI composeRibbonController(DriversEntityTableAdatper adapter) {
    return CategoryLayoutRibbonController(
      onRefresh: adapter.refresh,
      dataManagementController: CategoryLayoutRibbonDataManagementGroupController(
        onCreate: () {
          Router router = Injector.get<Router>();

          router.go(FoundationRoutes.driversCreateWhisperRoute);
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
    return DriversPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [DriverCommon] business entity to interact and manage data related with it.
final class DriversPage extends EntityPageB<DriversEntityTableAdatper> {
  /// Creates a new [DriversPage] instance.
  DriversPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return DriversEntityTable(
      adapter: adapter,
    );
  }
}
