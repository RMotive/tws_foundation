import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/widgets/entity_table/entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/widgets/property_viewer.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements a custom [EntityTableAdapterB] for a [Solution] based [EntityTable] providing a foundation
/// {csm} data handling table for [Solution].
final class YardLogsEntityTableAdapter extends EntityTableAdapterB<YardLog> {
  /// Callback to get authentication token due to [SolutionsServiceI.update] service needs authorization token,
  /// {FoundationView} package doesn't have authentication or session control.
  final FutureOr<String> Function() authBuilder;

  /// Creates a new [YardLogsEntityTableAdapter] instance.
  YardLogsEntityTableAdapter({
    required this.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, YardLog entity) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: <Widget>[
            /// --> Event property view.
            PropertyViewer(
              label: 'Event',
              value: entity.entry ? 'In' : 'Out',
            ),

            /// --> Load Type property view.
            PropertyViewer(
              label: 'Load Type',
              value: entity.loadType.name,
            ),

            PropertyViewer(
              label: 'Timestamp',
              value: entity.timestamp.fullDateString,
            ),
          ],
        ),
      ),
    );
  }
}

/// {widget} class.
///
/// Draws a {CSM} foundation [Solution] based [EntityTable], providing default interactions and management for [Solution] entity.
final class YardLogsEntityTable extends StatelessWidget {
  /// Table adapter handler.
  final YardLogsEntityTableAdapter adapter;

  /// Creates a new [YardLogsEntityTable] instance.
  const YardLogsEntityTable({
    super.key,
    required this.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<YardLog, YardLogsServiceI>(
      adapter: adapter,
      entityFactory: () => Solution(),
      authGenerator: () async {
        final SecurityServiceI securityService = Injector.get<SecurityServiceI>();

        final FoundationResponseResolver<SessionData> authOutputResolver = await securityService.authenticate(
          AuthenticationInput.a('TWSMF', 'local_user', 'local_user'.bytes),
        );

        return authOutputResolver
            .resolveDirect(
              () => SessionData(),
            )
            .token;
      },
      columns: <EntityTableColumnOptions<Solution>>[
        EntityTableColumnOptions<Solution>(
          title: 'Sign',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.sign,
        ),
        EntityTableColumnOptions<Solution>(
          title: 'Name',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.name,
        ),
        EntityTableColumnOptions<Solution>(
          title: 'Description',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.description,
        ),
      ],
    );
  }
}
