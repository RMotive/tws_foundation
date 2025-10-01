import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {whisper} class.
final class EmployeesPageCreateWhisper extends PageB {

  /// Creates a new [EmployeesPageCreateWhisper] instance.
  const EmployeesPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();
    return Whisper(
      title: 'Create Employee(s)',
      onPerform: () {
        creationController.create();
      },
      child: (GlobalKey<FormState> formState) {
        return CreateEntityForm<Employee, EmployeesServiceI>(
          entityFactory: () => Employee(),
          controller: creationController,
          buildEntityTag: (Employee entity) {
            return 'Employee with name: ${entity.fullName}';
          },
          recordDesigner: (Employee entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField>[
                /// --> Employee Name
                CreateEntityFormRecordField(
                  label: 'Name',
                  value: entity.identification.name,
                ),

                /// --> Employee Last Name
                CreateEntityFormRecordField(
                  label: 'Last Name',
                  value: entity.identification.lastName,
                ),
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Employee>? itemState) {
            final bool formDisabled = !(itemState == null);

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 12,
                children: <Widget>[
                  /// --> Employee Full Name
                  Row(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// --> Employee Name
                      Expanded(
                        child: TextInput(
                          label: 'Name',
                          isEnabled: formDisabled,
                          controller: TextEditingController(
                            text: itemState?.entity.identification.name,
                          ),
                          onChanged: (String text) {
                            Employee employee = itemState!.entity;

                            employee.identification.name = text;
                            itemState.react();
                          },
                        ),
                      ),

                      /// --> Property Last Name.
                      Expanded(
                        child: TextInput(
                          label: 'Last Name',
                          isEnabled: formDisabled,
                          controller: TextEditingController(
                            text: itemState?.entity.identification.lastName,
                          ),
                          onChanged: (String text) {
                            Employee employee = itemState!.entity;

                            employee.identification.lastName = text;
                            itemState.react();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
