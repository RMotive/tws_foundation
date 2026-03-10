import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/data/const/static_collections.dart';
import 'package:tws_foundation_view/src/view/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/datepicker_field.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Address state class.
class _AddresState extends ReactorBase {}

_AddresState _addressState = _AddresState();
// ignore: unused_element
void Function() _addressEffect = () {};

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
    List<Widget> scopeColumns = <Widget>[];

    if (entity.internal != null) {
      scopeColumns = <Widget>[
        const SectionDivider(text: 'Employee Identity'),
        PropertyViewer<String>(
          label: 'Name',
          value: entity.internal?.employee.identification.name,
        ),
        PropertyViewer<String>(
          label: 'First last name',
          value: entity.internal?.employee.identification.firstLastName,
        ),
        PropertyViewer<String>(
          label: 'Second last name',
          value: entity.internal?.employee.identification.secondLastName,
        ),
        PropertyViewer<String>(
          label: 'Birthday',
          value: entity.internal?.employee.identification.birthDay?.dateOnly,
        ),
        const SectionDivider(text: 'Driver Information'),
        PropertyViewer<String>(
          label: 'License Expiration',
          value: entity.internal?.licenseExpiration?.dateOnly,
        ),
        PropertyViewer<String>(
          label: 'Driver Type',
          value: entity.internal?.driverType,
        ),
        PropertyViewer<String>(
          label: 'Visa',
          value: entity.internal?.visa,
        ),
        PropertyViewer<String>(
          label: 'ANAM',
          value: entity.internal?.anam,
        ),
        PropertyViewer<String>(
          label: 'Twic',
          value: entity.internal?.twic,
        ),
        PropertyViewer<String>(
          label: 'Fast',
          value: entity.internal?.fast,
        ),
        PropertyViewer<String>(
          label: 'Drug. Alc. date',
          value: entity.internal?.drugAlcRegistrationDate?.dateOnly,
        ),
        PropertyViewer<String>(
          label: 'Pull notice date',
          value: entity.internal?.pullNoticeRegistrationDate?.dateOnly,
        ),
        const SectionDivider(text: 'Employee documents'),
        PropertyViewer<String>(
          label: 'CURP',
          value: entity.internal?.employee.curp,
        ),
        PropertyViewer<String>(
          label: 'RFC',
          value: entity.internal?.employee.rfc,
        ),
        PropertyViewer<String>(
          label: 'NSS',
          value: entity.internal?.employee.nss,
        ),
        PropertyViewer<String>(
          label: 'Imss registration',
          value: entity.internal?.employee.dates.imss?.dateOnly,
        ),
        PropertyViewer<String>(
          label: 'Hire date',
          value: entity.internal?.employee.dates.hire?.dateOnly,
        ),
        PropertyViewer<String>(
          label: 'Termination date',
          value: entity.internal?.employee.dates.termination?.dateOnly,
        ),
        PropertyViewer<String>(
          label: 'Cnap date',
          value: entity.internal?.employee.dates.cnap?.dateOnly,
        ),

        if (entity.internal?.employee.approach != null) ...<Widget>[
          const SectionDivider(
            text: 'Contact',
          ),
          PropertyViewer<String>(
            label: 'Email',
            value: entity.internal?.employee.approach?.email,
          ),
          PropertyViewer<String>(
            label: 'Personal phone',
            value: entity.internal?.employee.approach?.personal,
          ),
          PropertyViewer<String>(
            label: 'Enterprise phone',
            value: entity.internal?.employee.approach?.enterprise,
          ),
          PropertyViewer<String>(
            label: 'Alternative contact',
            value: entity.internal?.employee.approach?.alternative,
          ),
        ],
        
        if (entity.internal?.employee.address != null) ...<Widget>[
          const SectionDivider(
            text: 'Address',
          ),
          PropertyViewer<String>(
            label: 'Country',
            value: entity.internal?.employee.address?.country,
          ),
          PropertyViewer<String>(
            label: 'City',
            value: entity.internal?.employee.address?.city,
          ),
          PropertyViewer<String>(
            label: 'Street',
            value: entity.internal?.employee.address?.street,
          ),
          PropertyViewer<String>(
            label: 'Alt. Street',
            value: entity.internal?.employee.address?.altStreet,
          ),
          PropertyViewer<String>(
            label: 'Zip',
            value: entity.internal?.employee.address?.zip,
          ),
          PropertyViewer<String>(
            label: 'Subdivision/Colonia',
            value: entity.internal?.employee.address?.subdivision,
          ),
        ],
      ];
    }

    if (entity.external != null) {
      scopeColumns = <Widget>[
        const SectionDivider(
          text: 'Employee identity',
        ),
        PropertyViewer<String>(
          label: 'Name',
          value: entity.external?.identification.name,
        ),
        PropertyViewer<String>(
          label: 'First Last name',
          value: entity.external?.identification.firstLastName,
        ),
        PropertyViewer<String>(
          label: 'Second Last name',
          value: entity.external?.identification.secondLastName,
        ),
      ];
    }

    return SingleChildScrollView(
      child: EntityTableViewer(
        children: <Widget>[
          const SectionDivider(
            text: 'Common information',
          ),
          PropertyViewer<String>(
            label: 'Timestamp',
            value: entity.timestamp.toString(),
          ),
          PropertyViewer<String>(
            label: 'License',
            value: entity.license,
          ),
          PropertyViewer<String>(
            label: 'Ownership',
            value: entity.internal != null ? "Own" : 'External',
          ),
          PropertyViewer<String>(
            label: 'Situation',
            value:  entity.situation?.name ?? '--- ',
          ),
          PropertyViewer<String>(
            label: 'Status',
            value: entity.status.name,
          ),
          ...scopeColumns,
        ],
      ),
    );
  }

  @override
  EntityTableAdapterEditor<DriverCommon>? composeEditor() {
    return EntityTableAdapterEditor<DriverCommon>(
      onUpdate: (EntityTableAdapterEditorData<DriverCommon> data) {
        final Router router = InjectorUtils.get();

        showDialog(
          context: data.context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            if (data.entity.internal != null) return _buildInternalDialog(data.entity, router, context);
            return _buildExternalDialog(data.entity, router, context);
          },
        );
      },
      formBuilder: (EntityTableAdapterEditorData<DriverCommon> data) {
        
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 10,
            children: <Widget>[
              const SectionDivider(text: 'Common details'),
              TextInput(
                label: "TimeStamp",
                controller: TextEditingController(
                  text: data.entity.timestamp.toString()
                ),
                isEnabled: false,
              ),
              TextInput(
                label: "*License",
                hint: "Enter a License number",
                maxLength: 12,
                controller: TextEditingController(
                  text: data.entity.license,
                ),
                onChanged: (String text) {
                  data.entity.license = text;
                },
              ),
              EntityFinderSelector<Status, StatusesServiceI>(
                label: "*Status",
                initialValue: data.entity.status,
                entityBuilder: () => Status(),
                textBuilder: (Status entity) {
                  return entity.name.cleaned ?? "---";
                },
                onSelected: (Status? selectedItem) {
                  data.entity.status = selectedItem ?? Status();

                  if (data.entity.internal != null){
                    data.entity.internal?.employee.status = selectedItem ?? Status();
                    data.entity.internal?.employee.approach?.status = selectedItem ?? Status();
                  }
                },
              ),
              EntityFinderSelector<Situation, SituationsServiceI>(
                label: "Situation",
                initialValue: data.entity.situation,
                entityBuilder: () => Situation(),
                textBuilder: (Situation entity) {
                  return entity.name.cleaned ?? "---";
                },
                onSelected: (Situation? selectedItem) {
                  data.entity.situation = selectedItem ?? Situation();
                },
              ),
          
              data.entity.internal != null? _internalEditorFormBuilder(data.entity) : _externalEditorFormBuilder(data.entity),
            ],
          ),
        );
      },
    );
  }

  Widget _identificationSection(DriverCommon entity) {
    return Column(
      spacing: 10,
      children: <Widget>[
        SectionDivider(text: 'Identity'),
        TextInput(
          label: "*Name",
          hint: "Enter a name",
          maxLength: 32,
          controller: TextEditingController(
            text: entity.internal?.employee.identification.name ?? entity.external?.identification.name,
          ),
          onChanged: (String text) {
            if (entity.internal != null) {
              entity.internal?.employee.identification.name = text;
            } else {
              entity.external?.identification.name = text;
            }
          },
        ),
        TextInput(
          label: "*First Lastname",
          hint: "enter a lastname",
          maxLength: 32,
          controller: TextEditingController(
            text: entity.internal?.employee.identification.firstLastName ?? entity.external?.identification.firstLastName,
          ),
          onChanged: (String text) {
            if (entity.internal != null) {
              entity.internal?.employee.identification.firstLastName = text;
            } else {
              entity.external?.identification.firstLastName = text;
            }
          },
        ),
        TextInput(
          label: "Second Lastname",
          hint: "enter a lastname",
          maxLength: 32,
          controller: TextEditingController(
            text: entity.internal?.employee.identification.secondLastName ?? entity.external?.identification.secondLastName,
          ),
          onChanged: (String text) {
            if (entity.internal != null) {
              entity.internal?.employee.identification.secondLastName = text;
            } else {
              entity.external?.identification.secondLastName = text;
            }
          },
        ),
        Datepicker(
          width: double.maxFinite,
          firstDate: DateTime(1940),
          lastDate: DateTime(2040),
          label: "Birthday",
          suffixLabel: ' opt.',
          controller: TextEditingController(
            text:
                entity.internal?.employee.identification.birthDay?.dateOnly ??
                entity.external?.identification.birthDay?.dateOnly,
          ),
          onChanged: (String text) {
            if (entity.internal != null) {
              entity.internal?.employee.identification.birthDay = DateTime.tryParse(text) ?? DateTime(0);
            } else {
              entity.external?.identification.birthDay = DateTime.tryParse(text) ?? DateTime(0);
            }
          },
        ),
      ],
    );
  }

  Widget _externalEditorFormBuilder(DriverCommon entity) {
    return _identificationSection(entity);
  }

  Widget _internalEditorFormBuilder(DriverCommon entity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        spacing: 10,
        children: <Widget>[
          TextInput(
            label: "Driver type",
            hint: "Enter the driver type",
            suffixLabel: ' opt.',
            maxLength: 12,
            controller: TextEditingController(text: entity.internal?.driverType),
            onChanged: (String text) {
              entity.internal?.driverType = text;
            },
          ),
          Datepicker(
            width: double.maxFinite,
            firstDate: DateTime(1999),
            lastDate: DateTime(2040),
            label: "License expiration",
            suffixLabel: ' opt.',
            controller: TextEditingController(
              text: entity.internal?.licenseExpiration?.dateOnly,
            ),
            onChanged: (String text) {
              entity.internal?.licenseExpiration = DateTime.tryParse(text) ?? DateTime(0);
            },
          ),
          Datepicker(
            width: double.maxFinite,
            firstDate: DateTime(1999),
            lastDate: DateTime(2040),
            label: "Drugal reg. date",
            suffixLabel: ' opt.',
            controller: TextEditingController(
              text: entity.internal?.drugAlcRegistrationDate?.dateOnly,
            ),
            onChanged: (String text) {
              entity.internal?.drugAlcRegistrationDate = DateTime.tryParse(text) ?? DateTime(0);
            },
          ),
          Datepicker(
            width: double.maxFinite,
            firstDate: DateTime(1999),
            lastDate: DateTime(2040),
            label: "Pull notice reg. date",
            suffixLabel: ' opt.',
            controller: TextEditingController(
              text: entity.internal?.pullNoticeRegistrationDate?.dateOnly,
            ),
            onChanged: (String text) {
              entity.internal?.pullNoticeRegistrationDate = DateTime.tryParse(text) ?? DateTime(0);
            },
          ),
          TextInput(
            label: "TWIC number",
            hint: "Enter the TWIC number",
            suffixLabel: ' opt.',
            maxLength: 12,
            isFixedLength: true,
            controller: TextEditingController(text: entity.internal?.twic),
            onChanged: (String text) {
              entity.internal?.twic = text;
            },
          ),
          Datepicker(
            width: double.maxFinite,
            firstDate: DateTime(1999),
            lastDate: DateTime(2040),
            label: "TWIC expiration",
            suffixLabel: ' opt.',
            controller: TextEditingController(
              text: entity.internal?.twicExpiration?.dateOnly,
            ),
            onChanged: (String text) {
              entity.internal?.twicExpiration = DateTime.tryParse(text) ?? DateTime(0);
            },
          ),
          TextInput(
            label: "VISA number",
            hint: "Enter the VISA number",
            suffixLabel: ' opt.',
            maxLength: 12,
            isFixedLength: true,
            controller: TextEditingController(text: entity.internal?.visa),
            onChanged: (String text) {
              entity.internal?.visa = text;
            },
          ),
          Datepicker(
            width: double.maxFinite,
            firstDate: DateTime(1999),
            lastDate: DateTime(2040),
            label: "VISA expiration",
            suffixLabel: ' opt.',
            controller: TextEditingController(
              text: entity.internal?.visaExpiration?.dateOnly,
            ),
            onChanged: (String text) {
              entity.internal?.visaExpiration = DateTime.tryParse(text) ?? DateTime(0);
            },
          ),
          TextInput(
            label: "FAST number",
            hint: "Enter the FAST number",
            suffixLabel: ' opt.',
            maxLength: 14,
            isFixedLength: true,
            controller: TextEditingController(text: entity.internal?.fast),
            onChanged: (String text) {
              entity.internal?.fast = text;
            },
          ),
          Datepicker(
            width: double.maxFinite,
            firstDate: DateTime(1999),
            lastDate: DateTime(2040),
            label: "FAST expiration",
            suffixLabel: ' opt.',
            controller: TextEditingController(
              text: entity.internal?.fastExpiration?.dateOnly,
            ),
            onChanged: (String text) {
              entity.internal?.fastExpiration = DateTime.tryParse(text) ?? DateTime(0);
            },
          ),
          TextInput(
            label: "ANAM number",
            hint: "Enter the ANAM number",
            suffixLabel: ' opt.',
            maxLength: 24,
            isFixedLength: true,
            controller: TextEditingController(text: entity.internal?.anam),
            onChanged: (String text) {
              entity.internal?.anam = text;
            },
          ),
          Datepicker(
            width: double.maxFinite,
            firstDate: DateTime(1999),
            lastDate: DateTime(2040),
            label: "ANAM expiration",
            suffixLabel: ' opt.',
            controller: TextEditingController(
              text: entity.internal?.anamExpiration?.dateOnly,
            ),
            onChanged: (String text) {
              entity.internal?.anamExpiration = DateTime.tryParse(text);
            },
          ),
          _employeeSection(entity),
        ],
      ),
    );
  }

  Widget _employeeSection(DriverCommon entity) {
    return Column(
      spacing: 10,
      children: <Widget>[
        SectionDivider(text: 'Employee'),

        TextInput(
          label: "CURP",
          hint: "Enter a CURP number",
          suffixLabel: ' opt.',
          maxLength: 18,
          isFixedLength: true,
          controller: TextEditingController(
            text: entity.internal?.employee.curp,
          ),
          onChanged: (String text) {
            entity.internal?.employee.curp = text.cleaned;
          },
        ),

        TextInput(
          label: "RFC",
          hint: "Enter an RFC number",
          suffixLabel: ' opt.',
          maxLength: 13,
          isFixedLength: true,
          controller: TextEditingController(
            text: entity.internal?.employee.rfc,
          ),
          onChanged: (String text) {
            entity.internal?.employee.rfc = text.cleaned;
          },
        ),
        
        TextInput(
          label: "NSS",
          hint: "Enter an NSS number",
          suffixLabel: ' opt.',
          maxLength: 11,
          isFixedLength: true,
          controller: TextEditingController(
            text: entity.internal?.employee.nss,
          ),
          onChanged: (String text) {
            entity.internal?.employee.nss = text.cleaned;
          },
        ),

        Datepicker(
          width: double.maxFinite,
          firstDate: DateTime(1999),
          lastDate: DateTime(2040),
          label: "IMMS registration date",
          suffixLabel: ' opt.',
          controller: TextEditingController(
            text: entity.internal?.employee.dates.imss?.dateOnly,
          ),
          onChanged: (String text) {
            entity.internal?.employee.dates.imss = DateTime.tryParse(text);
          },
        ),

        Datepicker(
          width: double.maxFinite,
          firstDate: DateTime(1999),
          lastDate: DateTime(2040),
          label: "Hire date",
          suffixLabel: ' opt.',
          controller: TextEditingController(
            text: entity.internal?.employee.dates.hire?.dateOnly,
          ),
          onChanged: (String text) {
            entity.internal?.employee.dates.hire = DateTime.tryParse(text);
          },
        ),

        Datepicker(
          width: double.maxFinite,
          firstDate: DateTime(1999),
          lastDate: DateTime(2040),
          label: "Termination date",
          suffixLabel: ' opt.',
          controller: TextEditingController(
            text: entity.internal?.employee.dates.termination?.dateOnly,
          ),
          onChanged: (String text) {
            entity.internal?.employee.dates.termination = DateTime.tryParse(text);
          },
        ),

        Datepicker(
          width: double.maxFinite,
          firstDate: DateTime(1999),
          lastDate: DateTime(2040),
          label: "CNAP date",
          suffixLabel: ' opt.',
          controller: TextEditingController(
            text: entity.internal?.employee.dates.cnap?.dateOnly,
          ),
          onChanged: (String text) {
            entity.internal?.employee.dates.cnap = DateTime.tryParse(text);
          },
        ),

        _identificationSection(entity),

        if (entity.internal?.employee.approach != null)
          Column(
            spacing: 10,
            children: <Widget>[
              SectionDivider(text: 'Contact'),
              _approachSection(entity, false),
            ],
          ),

        if (entity.internal?.employee.approach == null)
          FoldPanelWidget(
            title: "Contact Information",
            child: _approachSection(entity, true),
          ),

        if (entity.internal?.employee.address != null)
          Column(
            spacing: 10,
            children: <Widget>[
              SectionDivider(text: 'Address'),
              _addressSection(entity, false),
            ],
          ),

        /// build a creation form.
        if (entity.internal?.employee.address == null)
          FoldPanelWidget(
            title: "Address",
            child: _addressSection(entity, true),
          ),
      ],
    );
  }

  Widget _addressSection(DriverCommon entity, bool isAdded) {
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
              entity.internal?.employee.address?.country == "" ? null : entity.internal?.employee.address?.country,
          displayValue: (String? item) => item ?? "Not valid data",
          onChanged: (String? text) {
            // Added entities can be nulleable, sanitize method will prevent null properties issues.
            if(isAdded){
              entity.internal?.employee.address =
                  entity.internal?.employee.address?.sanitize(
                    country: text ?? '',
                    state: '',
                  ) ??
                  Address().sanitize(
                    country: text ?? '',
                  );
            }else{
              entity.internal?.employee.address?.country = text ?? '';
            }
            
            _addressState.react();
          },
        ),
        ReactiveWidget<_AddresState>(
          reactor: _addressState,
          builder: (BuildContext ctx, _AddresState state) {
            String? currentCountry = entity.internal?.employee.address?.country;
            _addressEffect = state.react;
            return AutoCompleteField<String>(
              width: double.maxFinite,
              label: '${currentCountry ?? ''} State',
              suffixLabel: ' opt.',
              isOptional: true,
              isEnabled: currentCountry != null,
              nativeList: currentCountry == countryOptions[0] ? usaStateOptions : mxStateOptions,
              initialValue:
                  entity.internal?.employee.address?.state == "" ? null : entity.internal?.employee.address?.state,
              displayValue: (String? item) => item ?? "Not valid data",
              onChanged: (String? text) {
                if(isAdded){
                  entity.internal?.employee.address =
                      entity.internal?.employee.address?.sanitize(state: text ?? '') ??
                      Address().sanitize(state: text ?? '');
                  return;
                }
                entity.internal?.employee.address?.state = text.cleaned;
                
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
            text: entity.internal?.employee.address?.street,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.internal?.employee.address =
                entity.internal?.employee.address?.sanitize(state: text) ?? Address().sanitize(state: text);
              return;
            }
            entity.internal?.employee.address?.street = text.cleaned;
          },
        ),
        TextInput(
          label: "Alt. street",
          hint: "Enter an alt. street",
          suffixLabel: ' opt.',
          maxLength: 100,
          controller: TextEditingController(
            text: entity.internal?.employee.address?.altStreet,
          ),
          onChanged: (String text) {
            entity.internal?.employee.address =
                entity.internal?.employee.address?.sanitize(altStreet: text) ?? Address().sanitize(altStreet: text);
          },
        ),
        TextInput(
          label: "City",
          hint: "Enter a city",
          suffixLabel: ' opt.',
          maxLength: 30,
          controller: TextEditingController(
            text: entity.internal?.employee.address?.city,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.internal?.employee.address =
                entity.internal?.employee.address?.sanitize(city: text) ?? Address().sanitize(city: text);
              return;
            }
            entity.internal?.employee.address?.city = text.cleaned;
            
          },
        ),
        TextInput(
          label: "ZIP",
          hint: "Enter a ZIP number",
          suffixLabel: ' opt.',
          maxLength: 5,
          controller: TextEditingController(
            text: entity.internal?.employee.address?.zip,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.internal?.employee.address =
                entity.internal?.employee.address?.sanitize(zip: text) ?? Address().sanitize(zip: text);
            }
            entity.internal?.employee.address?.zip = text.cleaned;
          },
        ),
        TextInput(
          label: "Subdivision/Colonia",
          hint: "Enter a colonia",
          suffixLabel: ' opt.',
          maxLength: 100,
          controller: TextEditingController(
            text: entity.internal?.employee.address?.subdivision,
          ),
          onChanged: (String text) {
            if (isAdded) {
              entity.internal?.employee.address =
                  entity.internal?.employee.address?.sanitize(subdivision: text) ??
                  Address().sanitize(subdivision: text);
            }
            entity.internal?.employee.address?.subdivision = text.cleaned;
          },
        ),
      ],
    );
  }

  Widget _approachSection(DriverCommon entity, bool isAdded) {
    return Column(
      spacing: 10,
      children: <Widget>[
        TextInput(
          label: "Email",
          hint: "Enter an email",
          maxLength: 64,
          controller: TextEditingController(
            text: entity.internal?.employee.approach?.email,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.internal?.employee.approach =
                entity.internal?.employee.approach?.sanitize(email: text) ?? Approach().sanitize(email: text);
            }else{
              entity.internal?.employee.approach?.email = text;
            }

            entity.internal?.employee.approach?.status = entity.status;
          },
        ),
        TextInput(
          label: "Entreprise phone",
          suffixLabel: ' opt.',
          hint: "enter an entreprise phone",
          maxLength: 14,
          controller: TextEditingController(
            text: entity.internal?.employee.approach?.enterprise,
          ),
          onChanged: (String text) {
            if(isAdded){  
              entity.internal?.employee.approach =
                entity.internal?.employee.approach?.sanitize(enterprise: text) ?? Approach().sanitize(enterprise: text);
            }else{
              entity.internal?.employee.approach?.enterprise = text.cleaned;
            }

            entity.internal?.employee.approach?.status = entity.status;
          },
        ),
        TextInput(
          label: "Personal phone",
          suffixLabel: ' opt.',
          hint: "enter a personal phone",
          maxLength: 16,
          controller: TextEditingController(
            text: entity.internal?.employee.approach?.personal,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.internal?.employee.approach =
                entity.internal?.employee.approach?.sanitize(personal: text) ?? Approach().sanitize(personal: text);
            }else{
              entity.internal?.employee.approach?.personal = text.cleaned;
            }
           
            entity.internal?.employee.approach?.status = entity.status;
          },
        ),
        TextInput(
          label: "Alternative contact",
          suffixLabel: ' opt.',
          hint: "enter an alternative contact",
          maxLength: 30,
          controller: TextEditingController(
            text: entity.internal?.employee.approach?.alternative,
          ),
          onChanged: (String text) {
            if(isAdded){
              entity.internal?.employee.approach =
                entity.internal?.employee.approach?.sanitize(alternative: text) ??
                Approach().sanitize(alternative: text);
            }else{
              entity.internal?.employee.approach?.alternative = text.cleaned;
            }
            
            entity.internal?.employee.approach?.status = entity.status;
          },
        ),
      ],
    );
  }

  ResumeDialog _buildExternalDialog(DriverCommon entity, Router router, BuildContext context) {
    return ResumeDialog(
      acceptLabel: 'Update',
      title: 'Confirm Driver external Update',
      router: router,
      context: context,
      onAccept:() => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'License',
          value: entity.license,
        ),
        TextLabel(
          title: 'Situation',
          value: entity.situation?.name ?? '---',
        ),
        TextLabel(
          title: 'Status',
          value: entity.status.name,
        ),
        TextLabel(
          title: 'Name',
          value: entity.external?.identification.name ?? "---",
        ),
        TextLabel(
          title: 'First Lastname',
          value: entity.external?.identification.firstLastName ?? "---",
        ),
        TextLabel(
          title: 'Second Lastname',
          value: entity.external?.identification.secondLastName ?? "---",
        ),
      ],
    );
  }

  void _onUpdate(DriverCommon entity, Router router, BuildContext context) async {
    DriversServiceI driversService = InjectorUtils.get();

    List<EntityErrors<DriverCommon>> invalidations = entity.evaluate(<EntityErrors<DriverCommon>>[]);

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

    FoundationResponseResolver<UpdateOutput<DriverCommon>> resResolver = await driversService.update(
      UpdateInput<DriverCommon>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      factory:
          () => UpdateOutput<DriverCommon>(
            () => DriverCommon(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<DriverCommon>> success) {
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
        Navigator.of(context).pop();
        if (errMessage == null) return;

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              showCancelButton: false,
              title: 'Error Updating Driver',
              content: Text(
                errMessage as String,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              theming: ThemingUtils.get<FoundationThemeB>(context).controlError,
              onAccept: () {
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }

  ResumeDialog _buildInternalDialog(DriverCommon entity, Router router, BuildContext context) {
    return ResumeDialog(
      acceptLabel: 'Update',
      title: 'Confirm Driver Update',
      router: router,
      context: context,
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'License',
          value: entity.license,
        ),
        TextLabel(
          title: 'Situation',
          value: entity.situation?.name ?? '---',
        ),
        TextLabel(
          title: 'Status',
          value: entity.status.name,
        ),
        TextLabel(
          title: 'Name',
          value: entity.internal?.employee.identification.name ?? "---",
        ),
        TextLabel(
          title: 'First Lastname',
          value: entity.internal?.employee.identification.firstLastName ?? "---",
        ),
        TextLabel(
          title: 'Second Lastname',
          value: entity.internal?.employee.identification.secondLastName ?? "---",
        ),
        TextLabel(
          title: 'Birthday',
          value: entity.internal?.employee.identification.birthDay?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'License',
          value: entity.internal?.licenseExpiration?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'Driver type',
          value: entity.internal?.driverType ?? "---",
        ),
        TextLabel(
          title: 'VISA',
          value: entity.internal?.visa ?? "---",
        ),
        TextLabel(
          title: 'VISA Expiration',
          value: entity.internal?.visaExpiration?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'ANAM',
          value: entity.internal?.anam ?? "---",
        ),
        TextLabel(
          title: 'ANAM Expiration',
          value: entity.internal?.anamExpiration?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'TWIC',
          value: entity.internal?.twic ?? "---",
        ),
        TextLabel(
          title: 'TWIC Expiration',
          value: entity.internal?.twicExpiration?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'FAST',
          value: entity.internal?.fast ?? "---",
        ),
        TextLabel(
          title: 'FAST Expiration',
          value: entity.internal?.fastExpiration?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'Drug/Alc reg date',
          value: entity.internal?.drugAlcRegistrationDate?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'Pull notice reg date',
          value: entity.internal?.pullNoticeRegistrationDate?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'CURP',
          value: entity.internal?.employee.curp ?? "---",
        ),
        TextLabel(
          title: 'RFC',
          value: entity.internal?.employee.rfc ?? "---",
        ),
        TextLabel(
          title: 'NSS',
          value: entity.internal?.employee.nss ?? "---",
        ),
        TextLabel(
          title: 'IMSS reg. date',
          value: entity.internal?.employee.dates.imss?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'CNAP date',
          value: entity.internal?.employee.dates.cnap?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'Hiring date',
          value: entity.internal?.employee.dates.hire?.dateOnly ?? "---",
        ),
        TextLabel(
          title: 'Termination date',
          value: entity.internal?.employee.dates.termination?.dateOnly ?? "---",
        ),

        /// Contact information
        if (entity.internal?.employee.address != null) ...<TextLabel>[
          TextLabel(
            title: 'Email',
            value: entity.internal?.employee.approach?.email ?? "---",
          ),
          TextLabel(
            title: 'Personal phone',
            value: entity.internal?.employee.approach?.personal ?? "---",
          ),
          TextLabel(
            title: 'Enterprise phone',
            value: entity.internal?.employee.approach?.enterprise ?? "---",
          ),
          TextLabel(
            title: 'Alternative contact',
            value: entity.internal?.employee.approach?.alternative ?? "---",
          ),
        ],

        /// Address information
        if (entity.internal?.employee.address != null) ...<TextLabel>[
          TextLabel(
            title: 'Country',
            value: entity.internal?.employee.address?.country ?? "---",
          ),
          TextLabel(
            title: 'City',
            value: entity.internal?.employee.address?.city ?? "---",
          ),
          TextLabel(
            title: 'Street',
            value: entity.internal?.employee.address?.street ?? "---",
          ),
          TextLabel(
            title: 'Alt. street',
            value: entity.internal?.employee.address?.altStreet ?? "---",
          ),
          TextLabel(
            title: 'ZIP',
            value: entity.internal?.employee.address?.zip ?? "---",
          ),
          TextLabel(
            title: 'Subdivision/Colonia',
            value: entity.internal?.employee.address?.subdivision ?? "---",
          ),
        ],
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [DriverCommon] {entity}, also handles basic available behavior.
final class DriversEntityTable extends FoundationEntityTableB<DriverCommon, DriversEntityTableAdatper> {
  /// Creates a new [DriversEntityTable] instance.
  const DriversEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<DriverCommon, FoundationResponseResolver<ViewOutput<DriverCommon>>,DriversServiceI>(
      factory: () => DriverCommon(),
      adapter: adapter,
      columns: <EntityTableColumnData<DriverCommon>>[
        /// --> Name
        EntityTableColumnData<DriverCommon>(
          title: 'Name',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.name,
        ),

        /// --> License
        EntityTableColumnData<DriverCommon>(
          title: 'License',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.license,
        ),

        /// --> Onwership
        EntityTableColumnData<DriverCommon>(
          title: 'Ownership',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) =>
                  entity.internal != null ? "Own" : 'External',
        ),

        /// --> Onwership
        EntityTableColumnData<DriverCommon>(
          title: 'Driver Type',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.driverType ?? '---',
        ),

        /// --> CURP
        EntityTableColumnData<DriverCommon>(
          title: 'CURP',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.employee.curp ?? '---',
        ),

        /// --> RFC
        EntityTableColumnData<DriverCommon>(
          title: 'RFC',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.employee.rfc ?? '---',
        ),

        /// --> NSS
        EntityTableColumnData<DriverCommon>(
          title: 'NSS',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.employee.nss ?? '---',
        ),

        /// --> Hiring Date
        EntityTableColumnData<DriverCommon>(
          title: 'Hiring Date',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) =>
                  entity.internal?.employee.dates.hire?.toIso8601String() ?? '---',
        ),
      ],
    );
  }
}
