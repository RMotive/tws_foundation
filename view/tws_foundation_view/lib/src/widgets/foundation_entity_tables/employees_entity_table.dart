import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/widgets/entity_table/entity_table.dart';
import 'package:tws_foundation_view/src/widgets/entity_table/entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/widgets/foundation_entity_tables/_foundation_entity_table_b.dart';

/// {adapter} class.
///
/// Implements the [EntityTableAdapterB] for [EmployeesEntityTable] {widget}.
final class EmployessEntityTableAdatper extends FoundationEntityTableAdapterB<Employee> {
  /// Creates a new [EmployessEntityTableAdatper] instance.
  EmployessEntityTableAdatper({
    required super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Employee entity) {
    // TODO: implement composeViewer
    throw UnimplementedError();
  }
}

/// {widget} class.
/// 
/// Draws a {foundation} complex [EntityTable] based on [Employee] {entity}, also handles basic available behavior.
final class EmployeesEntityTable extends FoundationEntityTableB<EmployessEntityTableAdatper> {
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
          factory: (Employee entity, int index, BuildContext buildContext) => entity.identification.,
        ),
      ], 
    );
  }
}
