
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/widgets/property_viewer.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements a custom [EntityTableAdapterB] for a [Solution] based [EntityTable] providing a foundation
/// {csm} data handling table for [Solution].
final class YardLogsEntityTableAdapter extends FoundationEntityTableAdapterB<YardLog> {

  /// Creates a new [YardLogsEntityTableAdapter] instance.
  YardLogsEntityTableAdapter({
    required super.authBuilder,
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
    return EntityTable<YardLog, YardlogsServiceI>(
      adapter: adapter,
      entityFactory: () => YardLog(),
      columns: <EntityTableColumnOptions<YardLog>>[
        EntityTableColumnOptions<YardLog>(
          title: 'Entry',
          customFactory: (YardLog entity, int index, BuildContext buildContext) {
            return Icon(
              entity.entry ? Icons.check : Icons.close,
            );
          },
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Date',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.timestamp.toIso8601String(),
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Load Type',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.loadType.name,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Drivers License',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.driver.license,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Driver',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.driver.name,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Truck Number',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.economic,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Truck Plate',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.plates,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Trailer Number',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer.economic,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Trailer Plate',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer.plates,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Seal',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.seal,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Seal #2',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.sealAlt,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Origin - Destination',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.fromTo,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Damaged',
          customFactory: (YardLog entity, int index, BuildContext buildContext) {
            return Icon(
              entity.damage != null ? Icons.check : Icons.close,
            );
          },
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Section',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.section.name,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Guard',
          factory: (YardLog entity, int index, BuildContext buildContext) {
            Identification guardIdent = entity.guard.identification;

            return '${guardIdent.name} ${guardIdent.lastName}';
          },
        ),
      ],
    );
  }
}
