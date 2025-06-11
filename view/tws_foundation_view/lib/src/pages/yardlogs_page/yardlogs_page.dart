import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [YardLogsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
final class YardLogsCategoryPage implements CategoryLayoutPageI {
  /// Allows to override default [YardLogsCategoryPage] route configuration to provide a custom [Route] instance.
  final Route? cusRoute;

  @override
  final CategoryLayoutRibbonControllerI? ribbonController;

  const YardLogsCategoryPage({
    this.cusRoute,
    this.ribbonController,
  });

  @override
  String get title => 'Yard Logs';

  @override
  Route get route =>
      cusRoute ??
      Route(
        'yardlogs_view',
        name: 'yardlogs',
      );

  @override
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.departure_board,
      color: recomdColor,
    );
  }

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) => YardLogsPage();
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [YardLog] business entity to interact and manage data related with it.
final class YardLogsPage extends PageB {
  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Center(
      child: Text('HELLO THIS IS YARDLOGS PAGE'),
    );
  }
}
