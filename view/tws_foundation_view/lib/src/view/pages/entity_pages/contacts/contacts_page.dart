import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/contacts/contacts_page_create_whisper.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_category_page_b.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/entity_page_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {category page} class.
///
/// Implements a [CategoryLayoutPageI] defining default behavior for a [ContactsPage] category page implementation
/// providing direct configruation to use it at a [CategoryLayout] instance.
///
/// (@category Entity Pages)
final class ContactsCategoryPage extends EntityCategoryPageB<ContactsEntityTableAdapter> {
  /// Creates a new [ContactsCategoryPage] instance.
  ContactsCategoryPage({
    super.cusRoute,
  }) : super(
         title: 'Contacts',
         route: FoundationRoutes.contactsPageRoute,
       );

  @override
  List<RouteB> composeRoutes() {
    return <RouteB>[
      RouteWhisper<Object>(
        FoundationRoutes.contactsCreateWhisperRoute,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext _, RouteData _) {
          return ContactsPageCreateWhisper();
        },
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
  List<ActionsRibbonNodeI> composeRibbonController(ContactsEntityTableAdapter adapter) {
    return <ActionsRibbonNodeI>[
      ActionsRibbonRefresh(
        onRefresh: adapter.refresh,
      ),
      ActionsRisbbonCreate(
        onCreate: () {
          Injector.get<Router>().go(FoundationRoutes.contactsCreateWhisperRoute);
        },
      ),
    ];
  }

  @override
  Widget? composeIcon(Color? recomdColor) {
    return Icon(
      Icons.contacts_rounded,
      color: recomdColor,
    );
  }

  @override
  PageI composePage(BuildContext buildContext, RouteData routeData) {
    return ContactsPage(
      adapter: adapter,
    );
  }
}

/// {page} class.
///
/// Implements a [PageB], draws a complex {csm} design for the [Contact] business entity to interact and manage data related with it.
final class ContactsPage extends EntityPageB<ContactsEntityTableAdapter> {
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
