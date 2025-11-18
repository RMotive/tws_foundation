import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_table/entity_table.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_table/entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_table/entity_table_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';

/// {adapter} class.
///
/// Implements the [EntityTableAdapterB] for [AccountsEntityTable] {widget}.
final class AccountsEntityTableAdatper extends FoundationEntityTableAdapterB<Account> {
  /// Creates a new [AccountsEntityTableAdatper] instance.
  AccountsEntityTableAdatper({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Account entity) {
    return EntityTableViewer(
      children: <Widget>[
        /// --> Name
        PropertyViewer(
          label: 'User',
          value: entity.user,
        ),
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Account] {entity}, also handles basic available behavior.
final class AccountsEntityTable extends FoundationEntityTableB<AccountsEntityTableAdatper> {
  /// Creates a new [AccountsEntityTable] instance.
  const AccountsEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Account, AccountServiceI>(
      entityFactory: () => Account(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<Account>>[
        /// --> Name
        EntityTableColumnOptions<Account>(
          title: 'User',
          factory: (Account entity, int index, BuildContext buildContext) => entity.user,
        ),
      ],
    );
  }
}
