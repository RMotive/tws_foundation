import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/entity_table_filters.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/datepicker_field.dart';
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
        PropertyViewer<DateTime>(
          label: 'Fecha',
          value: entity.timestamp.toUtc(),
        ),

        PropertyViewer<String>(
          label: 'Trailer No.',
          value: entity.trailer?.economic,
        ),

        PropertyViewer<String>(
          label: 'Placas',
          value: entity.trailer?.plates,
        ),

        PropertyViewer<String>(
          label: 'Truck No.',
          value: entity.truck.economic,
        ),

        PropertyViewer<String>(
          label: 'Entrada',
          value: entity.timestamp.toLocal().fullDate,
        ),

        PropertyViewer<String>(
          label: 'Sección',
          value: entity.section?.name,
        ),

        PropertyViewer<String>(
          label: 'Compañia',
          value: entity.trailer?.internal?.carrier.name ?? entity.trailer?.external?.carrier ?? '---',
        ),

        PropertyViewer<String>(
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
    return EntityTable<YardLog, ResponseResolverBase<ViewOutput<YardLog>>, YardLogsServiceI>(
      adapter: adapter,
      callView: InjectorUtils.get<YardLogsServiceI>().inventoryTrailersView,
      factory: () => YardLog(),
      columns: <EntityTableColumnData<YardLog>>[
        EntityTableColumnData<YardLog>(
          title: 'Trailer No.',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.economic ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Placas',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.plates ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Truck No.',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.economic,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Entrada',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.timestamp.toLocal().fullDate,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Sección',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.section?.name ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Compañia',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.internal?.carrier.name ?? entity.trailer?.external?.carrier ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Posesión',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer == null? 'No Trailer': entity.trailer?.internal != null? 'Propio' : 'Externo',
        ),
      ],
      composeFilterDatas:(YardLog set, ViewDateFilter<YardLog> dateInterval) {
        return <IViewFilter<YardLog>>[
          /// --> Date filters
          ViewDateFilter<YardLog>.a(
            property: CorePropertiesConsts.timestamp,
            from: dateInterval.from,
            to: dateInterval.to,
          ),

          /// --> Logical filters
          EntityTableFilters<YardLog>(
            discriminator: ViewFilterDiscriminator.viewLogicalFilter.name,
            operator: ViewFilterLogicalOperators.and,
            filters: <ViewPropertyFilter<YardLog>>[
              ViewPropertyFilter<YardLog>.a(
                property: '${YardLog.kTrailer}.${TrailerCommon.kEconomic}',
                operator: ViewFilterOperators.contains,
                value: set.trailer?.economic.cleaned,
              ),
              ViewPropertyFilter<YardLog>.a(
                property: '${YardLog.kSection}.${CorePropertiesConsts.id}',
                operator: ViewFilterOperators.equal,
                value: set.section?.id,
              )
            ],
          ),
        ];
      },
      composeFiltersView: (YardLog set, ViewDateFilter<YardLog> dateInterval) {
        return <Widget>[
          EntityFinderSelector<Section, SectionsServiceI>(
            label: 'Section',
            entityBuilder: () => Section(),
            initialValue: set.section,
            textBuilder: (Section section) {
              return section.name;
            },
            onSelected: (Section? selSection) {
              set.section = selSection;
            },
          ),
          Datepicker(
            label: 'From date',
            controller: TextEditingController(
              text: dateInterval.from != DateTime(1) ? dateInterval.from.dateOnly : null,
            ),
            firstDate: DateTime(1999),
            lastDate: DateTime.now().toUtc(),
            onChanged: (String? date) {
              dateInterval.from = DateTime.tryParse(date ?? '') ?? DateTime(1);
            },
          ),
          Datepicker(
            label: 'To date',
            controller: TextEditingController(text: dateInterval.to?.dateOnly),
            firstDate: DateTime(1999),
            lastDate: DateTime.now().toUtc(),
            onChanged: (String? date) {
              dateInterval.to = DateTime.tryParse(date ?? '');
            },
          ),
          TextInput(
            width: 200,
            label: 'Trailer No.',
            hint: 'search by trailer number',
            controller: TextEditingController(text: set.trailer?.economic ?? ''),
            onChanged: (String? value) {
              set.trailer ??= TrailerCommon();
              set.trailer?.economic = value ?? '';
            },
          ),
        ];
      },
    );
  }
}
