import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/data/const/static_collections.dart';
import 'package:tws_foundation_view/src/view/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/datepicker_field.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Address state class.
class _AddresState extends ReactorB {}

_AddresState _addressState = _AddresState();
// ignore: unused_element
void Function() _addressEffect = () {};

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
        const SectionDivider(text: 'Employee Information'),

        /// --> Timestamp
        PropertyViewer(
          label: 'Timestamp',
          value: entity.timestamp.fullDate,
        ),

        /// --> Status
        PropertyViewer(
          label: 'Status',
          value: entity.status.name,
        ),

        /// --> Name
        PropertyViewer(
          label: 'Name',
          value: entity.identification.fullname,
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

        /// --> Imss date
        PropertyViewer(
          label: 'IMSS date',
          value: entity.dates.imss?.dateOnly ?? '---',
        ),

        /// --> CNAP date
        PropertyViewer(
          label: 'CNAP date',
          value: entity.dates.cnap?.dateOnly ?? '---',
        ),

        /// --> Hiring date
        PropertyViewer(
          label: 'Hiring date',
          value: entity.dates.hire?.dateOnly ?? '---',
        ),

        /// --> Imss date
        PropertyViewer(
          label: 'Termination date',
          value: entity.dates.termination?.dateOnly ?? '---',
        ),

        if(entity.approach != null) ...<Widget>[
          const SectionDivider(text: 'Contact Information'),
          /// --> Email
          PropertyViewer(
            label: 'Email',
            value: entity.approach?.email.cleaned ?? '---',
          ),
          /// --> Personal phone
          PropertyViewer(
            label: 'Personal phone',
            value: entity.approach?.personal.cleaned ?? '---',
          ),
          /// --> Enterprise phone
          PropertyViewer(
            label: 'Enterprise phone',
            value: entity.approach?.enterprise.cleaned ?? '---',
          ),
          /// --> Alternative Contact
          PropertyViewer(
            label: 'Alternative contact',
            value: entity.approach?.alternative.cleaned ?? '---',
          ),
        ],

        
        if(entity.address != null) ...<Widget>[
          const SectionDivider(text: 'Address Information'),
          /// --> Country
          PropertyViewer(
            label: 'Country',
            value: entity.address?.country,
          ),
          /// --> State
          PropertyViewer(
            label: 'State',
            value: entity.address?.state,
          ),
          /// --> City
          PropertyViewer(
            label: 'City',
            value: entity.address?.city,
          ),
          /// --> Street
          PropertyViewer(
            label: 'Street',
            value: entity.address?.street,
          ),
          /// --> alt. street
          PropertyViewer(
            label: 'Alt. street',
            value: entity.address?.altStreet,
          ),
          /// --> Subdivision / Colonia
          PropertyViewer(
            label: 'subdivision/Colonia',
            value: entity.address?.subdivision,
          ),

        ],
      ],
    );
  }

  @override
  EntityTableAdapterEditor<Employee>? composeEditor() {    
    return EntityTableAdapterEditor<Employee>(
      onUpdate: (BuildContext buildContext, Employee entity) {
        final Router router = Injector.get();

        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(entity, router, context),
        );
      },

      formBuilder:(BuildContext buildContext, Employee entity) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[
              const SectionDivider(text: 'Permit details'),
              TextInput(
                width: double.infinity,
                label: 'Timestamp',
                isEnabled: false,
                controller: TextEditingController(
                  text: entity.timestamp.fullDate,
                ),
              ),
              EntityFinderSelector<Status, StatusesServiceI>(
                entityBuilder: () => Status(),
                label: '*Select a Status...',
                initialValue: entity.status,
                textBuilder: (Status status) {
                  return status.name;
                },
                onSelected: (Status? status) {
                  entity.status = status ?? Status();
                },
              ),
              TextInput(
                width: double.infinity,
                label: 'Curp',
                maxLength: 18,
                isFixedLength: true,
                controller: TextEditingController(
                  text: entity.curp,
                ),
                onChanged: (String text) {
                  entity.curp = text.cleaned;
                },
              ),
              TextInput(
                width: double.infinity,
                label: 'RFC',
                maxLength: 13,
                controller: TextEditingController(
                  text: entity.rfc,
                ),
                onChanged: (String text) {
                  entity.rfc = text.cleaned;
                },
              ),
              TextInput(
                width: double.infinity,
                label: 'NSS',
                maxLength: 11,
                controller: TextEditingController(
                  text: entity.nss,
                ),
                onChanged: (String text) {
                  entity.nss = text.cleaned;
                },
              ),

              Datepicker(
                width: double.maxFinite,
                label: 'IMSS registration date',
                controller: TextEditingController(text: entity.dates.imss?.dateOnly),
                firstDate: DateTime(1950), 
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  entity.dates.imss = DateTime.tryParse(date ?? '');
                },
              ),

              Datepicker(
                width: double.maxFinite,
                label: 'CNAP date',
                controller: TextEditingController(text: entity.dates.cnap?.dateOnly),
                firstDate: DateTime(1950), 
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  entity.dates.cnap = DateTime.tryParse(date ?? '');
                },
              ),

              Datepicker(
                width: double.maxFinite,
                label: 'Employee hiring date',
                controller: TextEditingController(text: entity.dates.hire?.dateOnly),
                firstDate: DateTime(1950), 
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  entity.dates.hire = DateTime.tryParse(date ?? '');
                },
              ),

              Datepicker(
                width: double.maxFinite,
                label: 'Termination date',
                controller: TextEditingController(text: entity.dates.termination?.dateOnly),
                firstDate: DateTime(1950), 
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  entity.dates.termination = DateTime.tryParse(date ?? '');
                },
              ),

              const SectionDivider(text: 'Identification details'),
              TextInput(
                width: double.infinity,
                label: '*Name',
                maxLength: 32,
                controller: TextEditingController(
                  text: entity.identification.name,
                ),
                onChanged: (String text) {
                  entity.identification.name = text;
                },
              ),
              TextInput(
                width: double.infinity,
                label: '*First lastname',
                maxLength: 32,
                controller: TextEditingController(
                  text: entity.identification.firstLastName,
                ),
                onChanged: (String text) {
                  entity.identification.firstLastName = text;
                },
              ),
              TextInput(
                width: double.infinity,
                label: 'Second Lastname',
                maxLength: 32,
                controller: TextEditingController(
                  text: entity.identification.secondLastName,
                ),
                onChanged: (String text) {
                  entity.identification.secondLastName = text.cleaned;
                },
              ),
              Datepicker(
                width: double.maxFinite,
                label: 'Birthday',
                controller: TextEditingController(text: entity.identification.birthDay?.dateOnly),
                firstDate: DateTime(1950), 
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  entity.identification.birthDay = DateTime.tryParse(date ?? '');
                },
              ),

              if (entity.address != null)
                Column(
                  spacing: 10,
                  children: <Widget>[
                    SectionDivider(text: 'Address'),
                    _addressSection(entity, false),
                  ],
                ),

              if (entity.address == null)
                FoldPanelWidget(
                  title: "Add Address Information",
                  child: _addressSection(entity,  true),
                ),

                if (entity.address != null)
                Column(
                  spacing: 10,
                  children: <Widget>[
                    SectionDivider(text: 'Contact'),
                    _approachSection(entity, false),
                  ],
                ),

              if (entity.address == null)
                FoldPanelWidget(
                  title: "Add Contact Information",
                  child: _approachSection(entity,  true),
                ),


            ],
          ),
        );
      },
    );
  }

  Widget _approachSection(Employee entity, bool isAdded) {
    return Column(
      spacing: 10,
      children: <Widget>[
        TextInput(
          label: "Email",
          hint: "Enter an email",
          maxLength: 64,
          controller: TextEditingController(
            text: entity.approach?.email,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.approach =
                entity.approach?.sanitize(email: text) ?? Approach().sanitize(email: text);
            }else{
              entity.approach?.email = text;
            }

            entity.approach?.status = entity.status;
          },
        ),
        TextInput(
          label: "Entreprise phone",
          suffixLabel: ' opt.',
          hint: "enter an entreprise phone",
          maxLength: 14,
          controller: TextEditingController(
            text: entity.approach?.enterprise,
          ),
          onChanged: (String text) {
            if(isAdded){  
              entity.approach =
                entity.approach?.sanitize(enterprise: text) ?? Approach().sanitize(enterprise: text);
            }else{
              entity.approach?.enterprise = text.cleaned;
            }

            entity.approach?.status = entity.status;
          },
        ),
        TextInput(
          label: "Personal phone",
          suffixLabel: ' opt.',
          hint: "enter a personal phone",
          maxLength: 16,
          controller: TextEditingController(
            text: entity.approach?.personal,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.approach =
                entity.approach?.sanitize(personal: text) ?? Approach().sanitize(personal: text);
            }else{
              entity.approach?.personal = text.cleaned;
            }
           
            entity.approach?.status = entity.status;
          },
        ),
        TextInput(
          label: "Alternative contact",
          suffixLabel: ' opt.',
          hint: "enter an alternative contact",
          maxLength: 30,
          controller: TextEditingController(
            text: entity.approach?.alternative,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.approach =
                entity.approach?.sanitize(alternative: text) ??
                Approach().sanitize(alternative: text);
            }else{
              entity.approach?.alternative = text.cleaned;
            }
            
            entity.approach?.status = entity.status;
          },
        ),
      ],
    );
  }

  Widget _addressSection(Employee entity, bool isAdded) {
    List<String> countryOptions = FoundationCollections.kCountryList;
    List<String> usaStateOptions = FoundationCollections.kUStateCodes;
    List<String> mxStateOptions = FoundationCollections.kMXStateCodes;

    return Column(
      spacing: 10,
      children: <Widget>[
        AutoCompleteField<String>(
          width: double.maxFinite,
          label: 'Country',
          isOptional: true,
          nativeList: FoundationCollections.kCountryList,
          initialValue:
              entity.address?.country == "" ? null : entity.address?.country,
          displayValue: (String? item) => item ?? "Not valid data",
          onChanged: (String? text) {
            // Added entities can be nulleable, sanitize method will prevent null properties issues.
            if(isAdded){
              entity.address =
                  entity.address?.sanitize(
                    country: text ?? '',
                    state: '',
                  ) ??
                  Address().sanitize(
                    country: text ?? '',
                  );
            }else{
              entity.address?.country = text ?? '';
            }
            
            _addressState.react();
          },
        ),
        ReactiveWidget<_AddresState>(
          reactor: _addressState,
          builder: (BuildContext ctx, _AddresState state) {
            String? currentCountry = entity.address?.country;
            _addressEffect = state.react;
            return AutoCompleteField<String>(
              width: double.maxFinite,
              label: '${currentCountry ?? ''} State',
              suffixLabel: ' opt.',
              isOptional: true,
              isEnabled: currentCountry != null,
              nativeList: currentCountry == countryOptions[0] ? usaStateOptions : mxStateOptions,
              initialValue:
                  entity.address?.state == "" ? null : entity.address?.state,
              displayValue: (String? item) => item ?? "Not valid data",
              onChanged: (String? text) {
                if(isAdded){
                  entity.address =
                      entity.address?.sanitize(state: text ?? '') ??
                      Address().sanitize(state: text ?? '');
                  return;
                }
                entity.address?.state = text.cleaned;
                
              },
            );
          },
        ),

        TextInput(
          label: "Street",
          hint: "Enter an street",
          suffixLabel: ' opt.',
          maxLength: 100,
          controller: TextEditingController(
            text: entity.address?.street,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.address =
                entity.address?.sanitize(state: text) ?? Address().sanitize(state: text);
              return;
            }
            entity.address?.street = text.cleaned;
          },
        ),
        TextInput(
          label: "Alt. street",
          hint: "Enter an alt. street",
          suffixLabel: ' opt.',
          maxLength: 100,
          controller: TextEditingController(
            text: entity.address?.altStreet,
          ),
          onChanged: (String text) {
            entity.address =
                entity.address?.sanitize(altStreet: text) ?? Address().sanitize(altStreet: text);
          },
        ),
        TextInput(
          label: "City",
          hint: "Enter a city",
          suffixLabel: ' opt.',
          maxLength: 30,
          controller: TextEditingController(
            text: entity.address?.city,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.address =
                entity.address?.sanitize(city: text) ?? Address().sanitize(city: text);
              return;
            }
            entity.address?.city = text.cleaned;
            
          },
        ),
        TextInput(
          label: "ZIP",
          hint: "Enter a ZIP number",
          suffixLabel: ' opt.',
          maxLength: 5,
          controller: TextEditingController(
            text: entity.address?.zip,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.address =
                entity.address?.sanitize(zip: text) ?? Address().sanitize(zip: text);
            }
            entity.address?.zip = text.cleaned;
          },
        ),
        TextInput(
          label: "Subdivision/Colonia",
          hint: "Enter a colonia",
          suffixLabel: ' opt.',
          maxLength: 100,
          controller: TextEditingController(
            text: entity.address?.subdivision,
          ),
          onChanged: (String text) {
            if (isAdded) {
              entity.address =
                  entity.address?.sanitize(subdivision: text) ??
                  Address().sanitize(subdivision: text);
            }
            entity.address?.subdivision = text.cleaned;
          },
        ),
      ],
    );
  }

  void _onUpdate(Employee entity, Router router, BuildContext context) async {
    EmployeesServiceI employeesService = Injector.get();

    List<EntityInvalidation<Employee>> invalidations = entity.evaluate();

    if(invalidations.isNotEmpty){
      await showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InvalidatingDialog(
            title: 'Invalid Values',
            invalidations: invalidations,
            router: router,
            context: context,
          );
        },
      );
      return;
    }

    String authToken = await composeAuth();

    FoundationResponseResolver<UpdateOutput<Employee>> resResolver = await employeesService.update(
      UpdateInput<Employee>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      objectBuilder:
          () => UpdateOutput<Employee>(
            () => Employee(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<Employee>> success) {
        refresh();
      },
      onFailure: (FailureFrame failure, int status) {
        errMessage = failure.content.advise;
      },
      onException: (TracedException exception) {
        errMessage = FoundationMessages.unknownServerException;
      },
      onConnectionFailure: () {
        errMessage = FoundationMessages.connectionError;
      },
      onFinally: () {
        router.pop();
        if (errMessage == null) return;

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              showCancelButton: false,
              title: 'Error Updating contact',
              content: Text(
                errMessage as String,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              theming: Theming.get<FoundationThemeB>(context).error,
              onAccept: () {
                router.pop();
              },
            );
          },
        );
      },
    );
  }

  Widget _buildUpdateDialog(Employee entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Permit update',
      router: router,
      context: context,
      acceptLabel: 'Update',
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'Status',
          value: entity.status.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Name',
          value: entity.identification.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'First lastname',
          value: entity.identification.firstLastName.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Second lastname',
          value: entity.identification.secondLastName.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Birthday',
          value: entity.identification.birthDay?.dateOnly ?? '---',
        ),
        TextLabel(
          title: 'CURP',
          value: entity.curp ?? '---',
        ),
        TextLabel(
          title: 'RFC',
          value: entity.rfc ?? '---',
        ),
        TextLabel(
          title: 'NSS',
          value: entity.nss ?? '---',
        ),
        TextLabel(
          title: 'IMSS date',
          value: entity.dates.imss?.dateOnly ?? '---',
        ),
        TextLabel(
          title: 'CNAP date',
          value: entity.dates.imss?.dateOnly ?? '---',
        ),
        TextLabel(
          title: 'Hiring date',
          value: entity.dates.hire?.dateOnly ?? '---',
        ),
        TextLabel(
          title: 'Termination date',
          value: entity.dates.termination?.dateOnly ?? '---',
        ),

        /// Contact information
        if (entity.approach != null) ...<TextLabel>[
          TextLabel(
            title: 'Email',
            value: entity.approach?.email ?? "---",
          ),
          TextLabel(
            title: 'Personal phone',
            value: entity.approach?.personal ?? "---",
          ),
          TextLabel(
            title: 'Enterprise phone',
            value: entity.approach?.enterprise ?? "---",
          ),
          TextLabel(
            title: 'Alternative contact',
            value: entity.approach?.alternative ?? "---",
          ),
        ],

        /// Address information
        if (entity.address != null) ...<TextLabel>[
          TextLabel(
            title: 'Country',
            value: entity.address?.country ?? "---",
          ),
          TextLabel(
            title: 'City',
            value: entity.address?.city ?? "---",
          ),
          TextLabel(
            title: 'Street',
            value: entity.address?.street ?? "---",
          ),
          TextLabel(
            title: 'Alt. street',
            value: entity.address?.altStreet ?? "---",
          ),
          TextLabel(
            title: 'ZIP',
            value: entity.address?.zip ?? "---",
          ),
          TextLabel(
            title: 'Subdivision/Colonia',
            value: entity.address?.subdivision ?? "---",
          ),
        ],
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
