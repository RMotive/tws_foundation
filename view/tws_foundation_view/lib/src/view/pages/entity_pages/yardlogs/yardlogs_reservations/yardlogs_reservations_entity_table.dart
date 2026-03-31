import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


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
    return EntityTable<YardLog, ResponseResolverBase<ViewOutput<YardLog>>, YardLogsServiceI>(
      adapter: adapter,
      factory: () => YardLog(),
      overrideTap: (YardLog entity) {
        // Preload the selected reservation at the adapter to be used at the creation whisper.
        adapter.selectedReservation = entity;
        InjectorUtils.get<Router>().go(context, FoundationRoutes.yardlogsCreateWhisperRoute);
      },
      columns: <EntityTableColumnData<YardLog>>[
        EntityTableColumnData<YardLog>(
          title: 'Entry',
          customFactory: (YardLog entity, int index, BuildContext buildContext) {
            return Icon(
              entity.entry ? Icons.check : Icons.close,
            );
          },
        ),
        EntityTableColumnData<YardLog>(
          title: 'Date',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.timestamp.toIso8601String(),
        ),
        EntityTableColumnData<YardLog>(
          title: 'Load Type',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.loadType.name,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Drivers License',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.driver.license,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Driver',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.driver.name,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Truck Number',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.economic,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Truck Plate',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.plates,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Trailer Number',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.economic ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Trailer Plate',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.plates ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Seal',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.seal,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Seal #2',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.sealAlt,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Origin - Destination',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.fromTo,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Damaged',
          customFactory: (YardLog entity, int index, BuildContext buildContext) {
            return Icon(
              entity.getResource('damage') != null ? Icons.check : Icons.close,
            );
          },
        ),
        EntityTableColumnData<YardLog>(
          title: 'Section',
          factory: (YardLog entity, int index, BuildContext buildContext) =>  entity.section?.name ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Guard',
          factory: (YardLog entity, int index, BuildContext buildContext) {
            return entity.guard.identification.fullname;
          },
        ),
      ],
    );
  }
}
