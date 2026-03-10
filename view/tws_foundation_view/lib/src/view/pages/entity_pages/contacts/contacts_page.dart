import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/contacts/contacts_page_create_whisper.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [ICategoryLayoutPage] defining default behavior for a [ContactsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class ContactsCategoryPage extends EntityCategoryPageB<Contact, ContactsEntityTableAdapter> {
  /// Creates a new [ContactsCategoryPage] instance.
  ContactsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Contacts',
         routeData: FoundationRoutes.contactsPageRoute,
       );

  @override
  List<IRoutingGraphData> composeRoutes() {
    return <IRoutingGraphData>[
      RoutingGraphWhisperData<Object>(
        FoundationRoutes.contactsCreateWhisperRoute,
        whisperOptions: WhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) => ContactsPageCreateWhisper(),
      ),
    ];
  }

  @override
  ContactsEntityTableAdapter composeAdapter() {
    return ContactsEntityTableAdapter(
      authBuilder: authBuilder,
    );
  }

  @override
  List<IActionsRibbonNode> composeRibbonController(ContactsEntityTableAdapter adapter) {
    return <IActionsRibbonNode>[
      ActionsRisbbonRefresh(
        onRefresh:(_) => adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: (BuildContext context) {
          InjectorUtils.get<Router>().go(context, FoundationRoutes.contactsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(BuildContext context, Color? fgColor) {
    return Icon(
      Icons.contacts_rounded,
      color: fgColor,
    );
  }

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routeData) {
    return ContactsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [ViewPageBase], draws a complex {csm} design for the [Contact] business entity to interact and manage data related with it.
final class ContactsPage extends EntityViewPageBase<Contact, ContactsEntityTableAdapter> {
  /// Creates a new [ContactsPage] instance.
  ContactsPage({
    required super.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return ContactsEntityTable(
      adapter: adapter,
    );
  }
}
