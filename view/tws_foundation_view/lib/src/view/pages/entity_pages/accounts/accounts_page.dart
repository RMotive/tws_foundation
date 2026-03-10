import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/accounts/create_whisper/accounts_page_create_whisper.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [AccountsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class AccountsCategoryPage extends EntityCategoryPageB<Account, AccountsEntityTableAdatper> {
  /// Creates a new [AccountsCategoryPage] instance.
  AccountsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Accounts',
         routeData: FoundationRoutes.accountsPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData >[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.accountsCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => AccountsPageCreateWhisper(),
      ),
    ];
  }

  @override
  AccountsEntityTableAdatper composeAdapter() {
    return AccountsEntityTableAdatper(
      authBuilder: authBuilder,
    );
  }

  @override
  List<IActionsRibbonNode> composeRibbonController(AccountsEntityTableAdatper adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(BuildContext context) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.accountsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(_, Color? recomdColor) {
    return Icon(
      Icons.account_box,
      color: recomdColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return AccountsPage(
      adapter: adapter,
    );
  }
  
  @override
  RouteData get routeData => cusRoute ?? FoundationRoutes.accountsPageRoute;
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [Account] business entity to interact and manage data related with it.
final class AccountsPage extends EntityViewPageBase<Account, AccountsEntityTableAdatper> {
  /// Creates a new [AccountsPage] instance.
  AccountsPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return AccountsEntityTable(
      adapter: adapter,
    );
  }
}
