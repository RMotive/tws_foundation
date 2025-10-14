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
/// Implements the [EntityTableAdapterB] for [EmployeesEntityTable] {widget}.
final class EmployeesEntityTableAdatper extends FoundationEntityTableAdapterB<Employee> {
  /// Creates a new [EmployeesEntityTableAdatper] instance.
  EmployeesEntityTableAdatper({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Employee entity) {
    return EntityTableViewer(
      children: <Widget>[
        /// --> Name
        PropertyViewer(
          label: 'Name',
          value: entity.identification.name,
        ),

        /// --> Last Name
        PropertyViewer(
          label: 'First lastname',
          value: entity.identification.firstLastName,
        ),

        PropertyViewer(
          label: 'Second lastname',
          value: entity.identification.secondLastName,
        ),

        /// --> Last Name
        PropertyViewer(
          label: 'Birth Day',
          value: entity.identification.birthDay?.toIso8601String(),
        ),

        /// --> CURP
        PropertyViewer(
          label: 'CURP',
          value: entity.curp,
        ),

        /// --> RFC
        PropertyViewer(
          label: 'RFC',
          value: entity.rfc,
        ),

        /// --> NSS
        PropertyViewer(
          label: 'NSS',
          value: entity.nss,
        ),

        /// --> Address
        PropertyViewer(
          label: 'Address',
          value: entity.address?.street,
        ),
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Employee] {entity}, also handles basic available behavior.
final class EmployeesEntityTable extends FoundationEntityTableB<EmployeesEntityTableAdatper> {
  /// Creates a new [EmployeesEntityTable] instance.
  const EmployeesEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Employee, EmployeesServiceI>(
      entityFactory: () => Employee(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<Employee>>[
        /// --> Name
        EntityTableColumnOptions<Employee>(
          title: 'Name',
          factory: (Employee entity, int index, BuildContext buildContext) => entity.fullName,
        ),

        /// --> CURP
        EntityTableColumnOptions<Employee>(
          title: 'CURP',
          factory: (Employee entity, int index, BuildContext buildContext) => entity.curp,
        ),

        /// --> RFC
        EntityTableColumnOptions<Employee>(
          title: 'RFC',
          factory: (Employee entity, int index, BuildContext buildContext) => entity.rfc,
        ),

        /// --> NSS
        EntityTableColumnOptions<Employee>(
          title: 'NSS',
          factory: (Employee entity, int index, BuildContext buildContext) => entity.nss,
        ),

        /// --> Hiring Date
        EntityTableColumnOptions<Employee>(
          title: 'Hiring Date',
          factory: (Employee entity, int index, BuildContext buildContext) => entity.dates.hire?.toIso8601String(),
        ),
      ],
    );
  }
}
