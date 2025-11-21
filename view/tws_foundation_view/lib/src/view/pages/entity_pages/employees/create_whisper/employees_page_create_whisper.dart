import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/data/const/static_collections.dart';
import 'package:tws_foundation_view/src/view/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_datepicker_field.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_create_whisper_address_section.dart';
part '_create_whisper_approach_section.dart';

Status _defaultStatus = Status();
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

                /// --> Status
                CreateEntityFormRecordField(
                  label: 'Status',
                  value: entity.status.name.cleaned ?? '---',
                ),
                
                /// --> Employee Name
                CreateEntityFormRecordField(
                  label: 'Name',
                  value: entity.identification.name,
                ),

                /// --> Employee Last Name
                CreateEntityFormRecordField(
                  label: '*First last name',
                  value: entity.identification.firstLastName,
                ),

                /// --> Employee Birthday
                CreateEntityFormRecordField(
                  label: 'Birthday',
                  value: entity.identification.birthDay?.dateOnly ?? '---',
                ),

                /// --> Employee Second Last Name
                CreateEntityFormRecordField(
                  label: 'Second last name',
                  value: entity.identification.secondLastName,
                ),

                /// --> Employee CURP number
                CreateEntityFormRecordField(
                  label: 'CURP number',
                  value: entity.curp,
                ),

                /// --> Employee RFC number
                CreateEntityFormRecordField(
                  label: 'RFC number',
                  value: entity.rfc,
                ),

                /// --> Employee NSS number
                CreateEntityFormRecordField(
                  label: 'NSS number',
                  value: entity.nss,
                ),

                /// --> Employee IMSS registration date
                CreateEntityFormRecordField(
                  label: 'IMSS reg. Date',
                  value: entity.dates.imss?.dateOnly ?? '---',
                ),

                /// --> Employee CNAP date
                CreateEntityFormRecordField(
                  label: 'CNAP Date',
                  value: entity.dates.cnap?.dateOnly ?? '---',
                ),

                /// --> Employee Hiring date
                CreateEntityFormRecordField(
                  label: 'Hiring date',
                  value: entity.dates.hire?.dateOnly ?? '---',
                ),

                /// --> Employee Termination date
                CreateEntityFormRecordField(
                  label: 'Termination date',
                  value: entity.dates.termination?.dateOnly ?? '---',
                ),

                if(entity.approach != null) ...<CreateEntityFormRecordField>[
                  /// --> Employee Email
                  CreateEntityFormRecordField(
                    label: '*Email',
                    value: entity.approach?.email ?? '---',
                  ),

                  /// --> Employee Personal phone
                  CreateEntityFormRecordField(
                    label: 'Personal phone',
                    value: entity.approach?.personal ?? '---',
                  ),

                  /// --> Employee Enterprise phone
                  CreateEntityFormRecordField(
                    label: 'Enterprise phone',
                    value: entity.approach?.enterprise ?? '---',
                  ),

                  /// --> Employee alternative contact
                  CreateEntityFormRecordField(
                    label: 'Alternative contact',
                    value: entity.approach?.alternative ?? '---',
                  ),
                ],

                if(entity.address != null) ...<CreateEntityFormRecordField>[
                  CreateEntityFormRecordField(
                    label: 'Country',
                    value: entity.address?.country,
                  ),
                  CreateEntityFormRecordField(
                    label: 'State',
                    value: entity.address?.state ?? '---',
                  ),
                  CreateEntityFormRecordField(
                    label: 'City',
                    value: entity.address?.city ?? '---',
                  ),
                  CreateEntityFormRecordField(
                    label: 'Street',
                    value: entity.address?.street ?? '---',
                  ),
                  CreateEntityFormRecordField(
                    label: 'Alt. Street',
                    value: entity.address?.altStreet ?? '---',
                  ),
                  CreateEntityFormRecordField(
                    label: 'ZIP',
                    value: entity.address?.zip ?? '---',
                  ),
                  CreateEntityFormRecordField(
                    label: 'Subdivision/Colonia',
                    value: entity.address?.subdivision ?? '---',
                  ),
                ]

                


              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Employee>? itemState) {
            final bool formDisabled = !(itemState == null);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  spacing: 12,
                  children: <Widget>[
                    /// --> Employee Full Name
                    Row(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// --> Status
                        Expanded(
                          child: EntityFinderSelector<Status, StatusesServiceI>(
                            entityBuilder:() => Status(),
                            label: 'Select Status',
                            initialValue: itemState?.entity.status,
                            textBuilder: (Status status) {
                              return status.name;
                            },
                            onSelected: (Status? status) {
                              Employee employee = itemState!.entity;
                              _defaultStatus = status ?? Status();
                              employee.status = status ?? Status();
                              employee.approach?.status = status ?? Status();
                              itemState.react();  
                            },
                          ),
                        ),
                        /// --> Employee Name
                        Expanded(
                          child: TextInput(
                            label: '*Name',
                            isEnabled: formDisabled,
                            maxLength: 32,
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
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: <Widget>[
                         /// --> First last Name.
                        Expanded(
                          child: TextInput(
                            label: '*First Last Name',
                            isEnabled: formDisabled,
                            maxLength: 32,
                            controller: TextEditingController(
                              text: itemState?.entity.identification.firstLastName,
                            ),
                            onChanged: (String text) {
                              Employee employee = itemState!.entity;
                              employee.identification.firstLastName = text;
                              itemState.react();
                            },
                          ),
                        ),
                        /// --> Second last Name.
                        Expanded(
                          child: TextInput(
                            label: 'Second Last Name',
                            isEnabled: formDisabled,
                            maxLength: 32,
                            controller: TextEditingController(
                              text: itemState?.entity.identification.secondLastName,
                            ),
                            onChanged: (String text) {
                              Employee employee = itemState!.entity;
                              employee.identification.secondLastName = text;
                              itemState.react();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: <Widget>[
                        /// --> Birthday date.
                        Expanded(
                          child: Datepicker(
                            label: 'Birthday',
                            controller: TextEditingController(text: itemState?.entity.identification.birthDay?.dateOnly),
                            firstDate: DateTime(1950), 
                            lastDate: DateTime(DateTime.now().year),
                            onChanged: (String? date) {
                              Employee employee = itemState!.entity;
                              if (date == null) {
                                employee.identification.birthDay = null;
                                return;
                              }
                              employee.identification.birthDay = DateTime.tryParse(date);
                              itemState.react();
                            },
                          ),
                        ),
                        /// --> CURP number.
                        Expanded(
                          child: TextInput(
                            label: 'CURP',
                            isEnabled: formDisabled,
                            maxLength: 18,
                            controller: TextEditingController(
                              text: itemState?.entity.curp,
                            ),
                            onChanged: (String text) {
                              Employee employee = itemState!.entity;
                              employee.curp = text.cleaned;
                              itemState.react();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: <Widget>[
                        /// --> RFC number.
                        Expanded(
                          child: TextInput(
                            label: 'RFC',
                            isEnabled: formDisabled,
                            maxLength: 12,
                            controller: TextEditingController(
                              text: itemState?.entity.rfc,
                            ),
                            onChanged: (String text) {
                              Employee employee = itemState!.entity;
                              employee.rfc = text.cleaned;
                              itemState.react();
                            },
                          ),
                        ),
                        /// --> NSS number.
                        Expanded(
                          child: TextInput(
                            label: 'NSS',
                            isEnabled: formDisabled,
                            maxLength: 11,
                            controller: TextEditingController(
                              text: itemState?.entity.nss,
                            ),
                            onChanged: (String text) {
                              Employee employee = itemState!.entity;
                              employee.nss = text.cleaned;
                              itemState.react();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: <Widget>[
                        
                        /// --> Birthday date.
                        Expanded(
                          child: Datepicker(
                            label: 'IMSS Date',
                            controller: TextEditingController(text: itemState?.entity.dates.imss?.dateOnly),
                            firstDate: DateTime(1950), 
                            lastDate: DateTime(DateTime.now().year),
                            onChanged: (String? date) {
                              Employee employee = itemState!.entity;
                              if (date == null) {
                                employee.dates.imss = null;
                                return;
                              }
                              employee.dates.imss = DateTime.tryParse(date);
                              itemState.react();
                            },
                          ),
                        ),
                        /// --> CNAP date.
                        Expanded(
                          child: Datepicker(
                            label: 'CNAP Date',
                            controller: TextEditingController(text: itemState?.entity.dates.cnap?.dateOnly),
                            firstDate: DateTime(1950), 
                            lastDate: DateTime(DateTime.now().year),
                            onChanged: (String? date) {
                              Employee employee = itemState!.entity;
                              if (date == null) {
                                employee.dates.cnap = null;
                                return;
                              }
                              employee.dates.cnap = DateTime.tryParse(date);
                              itemState.react();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: <Widget>[
                        Expanded(
                          child: Datepicker(
                            label: 'Termination Date',
                            controller: TextEditingController(text: itemState?.entity.dates.termination?.dateOnly),
                            firstDate: DateTime(1950), 
                            lastDate: DateTime(DateTime.now().year),
                            onChanged: (String? date) {
                              Employee employee = itemState!.entity;
                              if (date == null) {
                                employee.dates.termination = null;
                                return;
                              }
                              employee.dates.termination = DateTime.tryParse(date);
                              itemState.react();
                            },
                          ),
                        ),
                        /// --> Hiring date.
                        Expanded(
                          child: Datepicker(
                            label: 'Hiring Date',
                            controller: TextEditingController(text: itemState?.entity.dates.hire?.dateOnly),
                            firstDate: DateTime(1950), 
                            lastDate: DateTime(DateTime.now().year),
                            onChanged: (String? date) {
                              Employee employee = itemState!.entity;
                              if (date == null) {
                                employee.dates.hire = null;
                                return;
                              }
                              employee.dates.hire = DateTime.tryParse(date);
                              itemState.react();
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SectionWidget(
                      outterPadding: EdgeInsets.symmetric(vertical: 10),
                      title: 'Contact information opt.', 
                      child: _CreateWhisperApproachSection(
                        isEnabled: formDisabled,
                        itemState: itemState,
                      )
                    ),
                    SectionWidget(
                      outterPadding: EdgeInsets.symmetric(vertical: 10),
                      title: 'Address information opt.', 
                      child: _CreateWhisperAddressSection(
                        isEnabled: formDisabled,
                        itemState: itemState,
                      )
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
