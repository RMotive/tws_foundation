import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/data/const/static_collections.dart';
import 'package:tws_foundation_view/src/view/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_datepicker_field.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Address state class.
class _AddresState extends ReactorB {}

_AddresState _addresState = _AddresState();
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
    List<Widget> edgeColumns = <Widget>[];

    if (entity.internal != null) {
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

    if (entity.external != null) {
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

  @override
  EntityTableAdapterEditor<DriverCommon>? composeEditor() {
    return EntityTableAdapterEditor<DriverCommon>(
      onUpdate: (BuildContext buildContext, DriverCommon entity) {
        final Router router = Injector.get();

        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            if (entity.internal != null) return _buildInternalDialog(entity, router, context);
            return _buildExternalDialog(entity, router, context);
          },
        );
      },
      formBuilder: (BuildContext buildContext, DriverCommon entity) {
        if (entity.internal != null) return _editorInternalFormBuilder(entity);
        return _editorExternalFormBuilder(entity);
      },
    );
  }

  Widget _identificationSection(DriverCommon entity) {
    return SectionWidget(
      outterPadding: const EdgeInsets.symmetric(vertical: 10),
      title: 'Identity',
      child: Column(
        spacing: 10,
        children: <Widget>[
          TextInput(
            label: "Name",
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
            label: "Lastname",
            hint: "enter a lastname",
            maxLength: 32,
            controller: TextEditingController(
              text: entity.internal?.employee.identification.lastName ?? entity.external?.identification.lastName,
            ),
            onChanged: (String text) {
              if (entity.internal != null) {
                entity.internal?.employee.identification.lastName = text;
              } else {
                entity.external?.identification.lastName = text;
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
      ),
    );
  }

  Widget _editorExternalFormBuilder(DriverCommon entity) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        spacing: 10,
        children: <Widget>[
          TextInput(
            label: "License",
            hint: "Enter a License number",
            maxLength: 12,
            controller: TextEditingController(
              text: entity.license,
            ),
            onChanged: (String text) {
              entity.license = text;
            },
          ),
          EntityFinderSelector<Situation, SituationsServiceI>(
            label: "Situation",
            initialValue: entity.situation,
            entityBuilder: () => Situation(),
            textBuilder: (Situation entity) {
              return entity.name.cleaned ?? "---";
            },
            onSelected: (Situation? selectedItem) {
              entity.situation = selectedItem ?? Situation();
            },
          ),
          EntityFinderSelector<Status, StatusesServiceI>(
            label: "Status",
            initialValue: entity.status,
            entityBuilder: () => Status(),
            textBuilder: (Status entity) {
              return entity.name.cleaned ?? "---";
            },
            onSelected: (Status? selectedItem) {
              entity.status = selectedItem ?? Status();
            },
          ),
          _identificationSection(entity),
        ],
      ),
    );
  }

  Widget _editorInternalFormBuilder(DriverCommon entity) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          spacing: 10,
          children: <Widget>[
            TextInput(
              label: "License",
              hint: "Enter a License number",
              maxLength: 12,
              controller: TextEditingController(
                text: entity.license,
              ),
              onChanged: (String text) {
                entity.license = text;
              },
            ),
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
            EntityFinderSelector<Situation, SituationsServiceI>(
              label: "Situation",
              initialValue: entity.situation,
              entityBuilder: () => Situation(),
              textBuilder: (Situation entity) {
                return entity.name.cleaned ?? "---";
              },
              onSelected: (Situation? selectedItem) {
                entity.situation = selectedItem ?? Situation();
              },
            ),
            EntityFinderSelector<Status, StatusesServiceI>(
              label: "Status",
              initialValue: entity.status,
              entityBuilder: () => Status(),
              textBuilder: (Status entity) {
                return entity.name.cleaned ?? "---";
              },
              onSelected: (Status? selectedItem) {
                entity.status = selectedItem ?? Status();
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
                entity.internal?.anamExpiration = DateTime.tryParse(text) ?? DateTime(0);
              },
            ),
            _identificationSection(entity),
            if (entity.internal?.employee.approach != null)
              SectionWidget(
                outterPadding: const EdgeInsets.symmetric(vertical: 10),
                title: 'Conctact',
                child: _approachSection(entity),
              ),

            if (entity.internal?.employee.approach == null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FoldPanelWidget(
                  title: "Add Contact Information",
                  child: _approachSection(entity),
                ),
              ),

            if (entity.internal?.employee.address != null)
              SectionWidget(
                outterPadding: const EdgeInsets.symmetric(vertical: 10),
                title: 'Address',
                child: _addressSection(entity),
              ),

            /// build a creation form.
            if (entity.internal?.employee.address == null)
              FoldPanelWidget(
                title: "Address",
                child: _addressSection(entity),
              ),
          ],
        ),
      ),
    );
  }

  Widget _addressSection(DriverCommon entity) {
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
            entity.internal?.employee.address =
                entity.internal?.employee.address?.sanitize(
                  country: text ?? '',
                  state: '',
                ) ??
                Address().sanitize(
                  country: text,
                );
            _addresState.react();
          },
        ),
        ReactiveWidget<_AddresState>(
          reactor: _addresState,
          builder: (BuildContext ctx, _AddresState state) {
            String? currentCountry = entity.internal?.employee.address?.country;
            final String country =
                entity.internal?.employee.address?.country == countryOptions[0]
                    ? countryOptions[0]
                    : entity.internal?.employee.address?.country == countryOptions[1]
                    ? countryOptions[1]
                    : "";
            _addressEffect = state.react;
            return AutoCompleteField<String>(
              width: double.maxFinite,
              label: '$country State',
              suffixLabel: ' opt.',
              isOptional: true,
              isEnabled: currentCountry == countryOptions[0] || currentCountry == countryOptions[1],
              nativeList: country == countryOptions[0] ? usaStateOptions : mxStateOptions,
              initialValue:
                  entity.internal?.employee.address?.state == "" ? null : entity.internal?.employee.address?.state,
              displayValue: (String? item) => item ?? "Not valid data",
              onChanged: (String? text) {
                entity.internal?.employee.address =
                    entity.internal?.employee.address?.sanitize(state: text ?? '') ??
                    Address().sanitize(state: text ?? '');
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
            entity.internal?.employee.address =
                entity.internal?.employee.address?.sanitize(state: text) ?? Address().sanitize(state: text);
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
            entity.internal?.employee.address =
                entity.internal?.employee.address?.sanitize(city: text) ?? Address().sanitize(city: text);
          },
        ),
        TextInput(
          label: "ZIP",
          hint: "Enter a ZIP number",
          suffixLabel: ' opt.',
          maxLength: 5,
          controller: TextEditingController(
            text: entity.internal?.employee.address?.city,
          ),
          onChanged: (String text) {
            entity.internal?.employee.address =
                entity.internal?.employee.address?.sanitize(zip: text) ?? Address().sanitize(zip: text);
          },
        ),
        TextInput(
          label: "Subdivision/Colonia",
          hint: "Enter a colonia",
          suffixLabel: ' opt.',
          maxLength: 100,
          controller: TextEditingController(
            text: entity.internal?.employee.address?.city,
          ),
          onChanged: (String text) {
            entity.internal?.employee.address =
                entity.internal?.employee.address?.sanitize(subdivision: text) ?? Address().sanitize(subdivision: text);
          },
        ),
      ],
    );
  }

  Widget _approachSection(DriverCommon entity) {
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
            entity.internal?.employee.approach =
                entity.internal?.employee.approach?.sanitize(email: text) ?? Approach().sanitize(email: text);
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
            entity.internal?.employee.approach =
                entity.internal?.employee.approach?.sanitize(enterprise: text) ?? Approach().sanitize(enterprise: text);
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
            entity.internal?.employee.approach =
                entity.internal?.employee.approach?.sanitize(personal: text) ?? Approach().sanitize(personal: text);
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
            entity.internal?.employee.approach =
                entity.internal?.employee.approach?.sanitize(alternative: text) ??
                Approach().sanitize(alternative: text);
          },
        ),
      ],
    );
  }

  Dialog _buildExternalDialog(DriverCommon entity, Router router, BuildContext context) {
    return Dialog(
      acceptLabel: 'Update',
      title: 'Confirm Driver external Update',
      content: Text.rich(
        TextSpan(
          text: 'Are you sure you want to update an external driver?',
          children: <InlineSpan>[
            const TextSpan(
              text: '\n',
            ),
            const TextSpan(
              text: '\n\u2022 License:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.license}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Name:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.external?.identification.name ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Lastname:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.external?.identification.lastName ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Birthday:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.external?.identification.birthDay?.dateOnly ?? "---"}'),
              ),
            ),
          ],
        ),
      ),
      onAccept: () async {
        DriversServiceI driversService = Injector.get();

        String authToken = await composeAuth();

        FoundationResponseResolver<UpdateOutput<DriverCommon>> resResolver = await driversService.update(
          UpdateInput<DriverCommon>(entity),
          authToken,
        );

        String? errMessage;
        resResolver.resolve(
          objectBuilder:
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
            router.pop();
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
                  theming: Theming.get<FoundationThemeB>(context).error,
                  onAccept: () {
                    router.pop();
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Dialog _buildInternalDialog(DriverCommon entity, Router router, BuildContext context) {
    return Dialog(
      acceptLabel: 'Update',
      title: 'Confirm Driver Update',
      content: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: 'Are you sure you want to update a driver?',
          children: <InlineSpan>[
            const TextSpan(
              text: '\n',
            ),
            const TextSpan(
              text: '\n\u2022 License:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.license}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Driver type:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.driverType ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Situation:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.situation.name}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Licence expiration:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.licenseExpiration?.dateOnly ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Drugal reg. date:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.drugAlcRegistrationDate?.dateOnly ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Pull notice reg. date:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.pullNoticeRegistrationDate?.dateOnly ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 TWIC number:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.twic ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 TWIC expiration:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.twicExpiration?.dateOnly ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 VISA number:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.visa ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 VISA expiration:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.visaExpiration?.dateOnly ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 FAST number:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.fast ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 FAST expiration:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.fastExpiration?.dateOnly ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 ANAM number:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.anam ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 ANAM expiration:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.anamExpiration?.dateOnly ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Name:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.identification.name ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Lastname:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.identification.lastName ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Birthday:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.identification.birthDay?.dateOnly ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Email:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.approach?.email ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Entreprise phone:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.approach?.enterprise ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Personal phone:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.approach?.personal ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Alternative contact:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.approach?.alternative ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Country:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.address?.country ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 State:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.address?.state ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Street:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.address?.street ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Alt. Street:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.address?.altStreet ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 City:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.address?.city ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 ZIP:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.address?.zip ?? "---"}'),
              ),
            ),
            const TextSpan(
              text: '\n\u2022 Colonia:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            WidgetSpan(
              baseline: TextBaseline.alphabetic,
              alignment: PlaceholderAlignment.bottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text('\n${entity.internal?.employee.address?.subdivision ?? "---"}'),
              ),
            ),
          ],
        ),
      ),
      onAccept: () async {
        DriversServiceI driversService = Injector.get();

        String authToken = await composeAuth();

        FoundationResponseResolver<UpdateOutput<DriverCommon>> resResolver = await driversService.update(
          UpdateInput<DriverCommon>(entity),
          authToken,
        );

        String? errMessage;
        resResolver.resolve(
          objectBuilder:
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
            router.pop();
            if (errMessage == null) return;

            showDialog(
              context: context,
              useRootNavigator: true,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  showCancelButton: false,
                  title: 'Error Updating Solution',
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
      },
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
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.name,
        ),

        /// --> License
        EntityTableColumnOptions<DriverCommon>(
          title: 'License',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.license,
        ),

        /// --> Onwership
        EntityTableColumnOptions<DriverCommon>(
          title: 'Ownership',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) =>
                  entity.internal != null ? "Own" : 'External',
        ),

        /// --> Onwership
        EntityTableColumnOptions<DriverCommon>(
          title: 'Driver Type',
          factory: (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.driverType ?? '---',
        ),

        /// --> CURP
        EntityTableColumnOptions<DriverCommon>(
          title: 'CURP',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.employee.curp ?? '---',
        ),

        /// --> RFC
        EntityTableColumnOptions<DriverCommon>(
          title: 'RFC',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.employee.rfc ?? '---',
        ),

        /// --> NSS
        EntityTableColumnOptions<DriverCommon>(
          title: 'NSS',
          factory:
              (DriverCommon entity, int index, BuildContext buildContext) => entity.internal?.employee.nss ?? '---',
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
