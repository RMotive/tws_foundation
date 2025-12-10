import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements a custom [EntityTableAdapterB] for a [YardLog] trailer inventory based [EntityTable] providing a foundation
/// {csm} data handling table for [YardLog] trailer inventory.
final class TrailersInventoryEntityTableAdapter extends FoundationEntityTableAdapterB<YardLog> {
  /// Creates a new [TrailersInventoryEntityTableAdapter] instance.
  TrailersInventoryEntityTableAdapter({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, YardLog entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: <Widget>[
        /// --> Name property viewer
        PropertyViewer(
          label: 'Trailer No.',
          value: entity.trailer?.economic ?? '---',
        ),

        PropertyViewer(
          label: 'Placas',
          value: entity.trailer?.plates ?? '---',
        ),

        PropertyViewer(
          label: 'Truck No.',
          value: entity.truck.economic,
        ),

        PropertyViewer(
          label: 'Entrada',
          value: entity.timestamp.toLocal().fullDate,
        ),

        PropertyViewer(
          label: 'Sección',
          value: entity.section?.name,
        ),

        PropertyViewer(
          label: 'Compañia',
          value: entity.trailer?.internal?.carrier.name ?? entity.trailer?.external?.carrier ?? '---',
        ),

        PropertyViewer(
          label: 'Posesión',
          value: entity.trailer == null? 'No Trailer': entity.trailer?.internal != null? 'Own' : 'External',
        ),

      ],
    );
  }
}
/// {widget} class.
///
/// Draws a {CSM} foundation [Solution] based [EntityTable], providing default interactions and management for [Solution] entity.
final class TrailerInventoryEntityTable extends StatelessWidget {
  /// Table adapter handler.
  final TrailersInventoryEntityTableAdapter adapter;

  /// Creates a new [SolutionsEntityTable] instance.
  const TrailerInventoryEntityTable({
    super.key,
    required this.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<YardLog, YardLogsServiceI>(
      adapter: adapter,
      customView: Injector.get<YardLogsServiceI>().inventoryTrailersView,
      entityFactory: () => YardLog(),
      columns: <EntityTableColumnOptions<YardLog>>[
        EntityTableColumnOptions<YardLog>(
          title: 'Trailer No.',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.economic ?? '---',
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Placas',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.plates ?? '---',
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Truck No.',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.economic,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Entrada',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.timestamp.toLocal().fullDate,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Sección',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.section?.name ?? '---',
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Compañia',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.internal?.carrier.name ?? entity.trailer?.external?.carrier ?? '---',
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Compañia',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer == null? 'No Trailer': entity.trailer?.internal != null? 'Own' : 'External',
        ),
      ],
    );
  }
}
