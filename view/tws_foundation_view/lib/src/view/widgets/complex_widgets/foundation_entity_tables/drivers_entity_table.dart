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
/// Implements the [EntityTableAdapterB] for [DriversEntityTableAdatper] {widget}.
final class DriversEntityTableAdatper extends FoundationEntityTableAdapterB<DriverCommon> {
  /// Creates a new [DriversEntityTableAdatper] instance.
  DriversEntityTableAdatper({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, DriverCommon entity) {
    List<Widget> edgeColumns = <Widget>[];

    if(entity.internal != null){
      edgeColumns = <Widget>[
        PropertyViewer(
          label: 'Name',
          value: entity.internal?.employee.identification.name,
        ),
        PropertyViewer(
          label: 'Last name',
          value: entity.internal?.employee.identification.lastName,
        ),
        PropertyViewer(
          label: 'License Expiration',
          value: entity.internal?.licenseExpiration?.toIso8601String(),
        ),
        PropertyViewer(
          label: 'Driver Type',
          value: entity.internal?.driverType,
        ),
        PropertyViewer(
          label: 'CURP',
          value: entity.internal?.employee.curp,
        ),
        PropertyViewer(
          label: 'Visa',
          value: entity.internal?.visa,
        ),
        PropertyViewer(
          label: 'ANAM',
          value: entity.internal?.anam,
        ),
        PropertyViewer(
          label: 'Twic',
          value: entity.internal?.twic,
        ),
        PropertyViewer(
          label: 'Fast',
          value: entity.internal?.fast,
        ),
        PropertyViewer(
          label: 'CURP',
          value: entity.internal?.employee.curp,
        ),
       
      ];
    }

    if(entity.external != null){
      edgeColumns = <Widget>[
        PropertyViewer(
          label: 'Name',
          value: entity.external?.identification.name,
        ),
        PropertyViewer(
          label: 'Last name',
          value: entity.external?.identification.lastName,
        ),
        
      ];
    }

    return EntityTableViewer(
      children: <Widget>[
        PropertyViewer(
          label: 'License',
          value: entity.license,
        ),
        PropertyViewer(
          label: 'Ownership',
          value: entity.internal != null ? "Own" : 'External',
        ),
        ...edgeColumns,
        
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [DriverCommon] {entity}, also handles basic available behavior.
final class DriversEntityTable extends FoundationEntityTableB<DriversEntityTableAdatper> {
  /// Creates a new [DriversEntityTable] instance.
  const DriversEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {

    return EntityTable<DriverCommon, DriversServiceI>(
      entityFactory: () => DriverCommon(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<DriverCommon>>[
        /// --> Name
        EntityTableColumnOptions<DriverCommon>(
          title: 'Name',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.name
        ),

        /// --> License
        EntityTableColumnOptions<DriverCommon>(
          title: 'License',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.license
        ),

        /// --> Onwership
        EntityTableColumnOptions<DriverCommon>(
          title: 'Ownership',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.internal != null ? "Own" : 'External',
        ),

        /// --> Onwership
        EntityTableColumnOptions<DriverCommon>(
          title: 'Driver Type',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.driverType ?? '---',
        ),

        /// --> CURP
        EntityTableColumnOptions<DriverCommon>(
          title: 'CURP',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.employee.curp ?? '---',
        ),

        /// --> RFC
        EntityTableColumnOptions<DriverCommon>(
          title: 'RFC',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.employee.rfc ?? '---',
        ),

        /// --> NSS
        EntityTableColumnOptions<DriverCommon>(
          title: 'NSS',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.employee.nss ?? '---',
        ),

        /// --> Hiring Date
        EntityTableColumnOptions<DriverCommon>(
          title: 'Hiring Date',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) =>
                  entity.internal?.employee.dates.hire?.toIso8601String() ?? '---',
        ),
      ],
    );
  }
}
