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
import 'package:tws_foundation_view/src/view/widgets/tws_datepicker_field.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_incremental_list.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Address state class.
class _PlateState extends ReactorB {}

_PlateState _addressState = _PlateState();
// ignore: unused_element
void Function() _addressEffect = () {};

/// Address state class.
class _TypeState extends ReactorB {}

_TypeState _typeState = _TypeState();
// ignore: unused_element
void Function() _typeEffect = () {};

/// {adapter} class.
///
/// implements the [FoundationEntityTableAdapterB] for [TrailerCommon] entities.
final class TrailersEntityTableAdapter extends FoundationEntityTableAdapterB<TrailerCommon> {
  TrailersEntityTableAdapter({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, TrailerCommon entity) {
    List<Widget> scopeColumn = <Widget>[];
    if (entity.internal != null) {
      scopeColumn = <Widget>[
        const SectionDivider(text: 'Carrier details'),

        PropertyViewer(
          label: 'Carrier',
          value: entity.internal?.carrier.name ?? '---',
        ),
        PropertyViewer(
          label: 'Carrier USDOT / MC',
          value: entity.internal?.carrier.usdot?.mc ?? '---',
        ),
        PropertyViewer(
          label: 'Carrier USDOT / SCAC',
          value: entity.internal?.carrier.usdot?.scac ?? '---',
        ),

        const SectionDivider(text: 'Maintenance details'),

        PropertyViewer(
          label: 'Anual Maintenance',
          value: entity.internal?.maintenance?.anual.dateOnly ?? '---',
        ),
        PropertyViewer(
          label: 'Trimestral Maintenance',
          value: entity.internal?.maintenance?.trimestral.dateOnly ?? '---',
        ),

        const SectionDivider(text: 'Model details'),

        PropertyViewer(
          label: 'Model',
          value: entity.internal?.model?.name ?? '---',
        ),
        PropertyViewer(
          label: 'Manufacturer',
          value: entity.internal?.model?.manufacturer.name ?? '---',
        ),

        const SectionDivider(text: 'SCT details'),

        PropertyViewer(
          label: 'SCT type',
          value: entity.internal?.sct?.type ?? '---',
        ),
        PropertyViewer(
          label: 'SCT number',
          value: entity.internal?.sct?.number ?? '---',
        ),
        PropertyViewer(
          label: 'SCT configuration',
          value: entity.internal?.sct?.configuration ?? '---',
        ),

        for (int i = 0; i < entity.internal!.plates.length; i++) ...<Widget>[
          SectionDivider(
            text: '${i + 1} - ${entity.internal?.plates[i].country} Plate',
          ),
          PropertyViewer(
            label: 'Identifier',
            value: entity.internal?.plates[i].identifier ?? '---',
          ),
          PropertyViewer(
            label: 'Expiration',
            value: entity.internal?.plates[i].expiration?.dateOnly ?? '---',
          ),
          PropertyViewer(
            label: 'State',
            value: entity.internal?.plates[i].state ?? '---',
          ),
        ],
      ];
    }

    if (entity.external != null) {
      scopeColumn = <Widget>[
        PropertyViewer(
          label: 'Carrier',
          value: entity.external?.carrier,
        ),
        PropertyViewer(
          label: 'USA Plate',
          value: entity.external?.usaPlate ?? '---',
        ),
        PropertyViewer(
          label: 'MX Plate',
          value: entity.external?.mxPlate ?? '---',
        ),
      ];
    }

    return SingleChildScrollView(
      child: EntityTableViewer(
        children: <Widget>[
          const SectionDivider(text: 'Common details'),
          PropertyViewer(
            label: 'Timestamp',
            value: entity.timestamp.toString(),
          ),
          PropertyViewer(
            label: 'Ownership',
            value:
                entity.internal != null
                    ? 'Own'
                    : entity.external != null
                    ? 'External'
                    : '---',
          ),
          PropertyViewer(
            label: 'Economic',
            value: entity.economic,
          ),
          PropertyViewer(
            label: 'Status',
            value: entity.status.name,
          ),
          PropertyViewer(
            label: 'Type',
            value: entity.classType ?? '---',
          ),
          PropertyViewer(
            label: 'Situation',
            value: entity.situation?.name ?? '---',
          ),
          PropertyViewer(
            label: 'Location',
            value: entity.location?.name ?? '---',
          ),

          ...scopeColumn,
        ],
      ),
    );
  }

  @override
  EntityTableAdapterEditor<TrailerCommon>? composeEditor() {
    return EntityTableAdapterEditor<TrailerCommon>(
      onUpdate: (BuildContext buildContext, TrailerCommon entity) {
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
      formBuilder: (BuildContext buildContext, TrailerCommon entity) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 10,
            children: <Widget>[
              const SectionDivider(text: 'Common details'),

              TextInput(
                label: "TimeStamp",
                controller: TextEditingController(text: entity.timestamp.toString()),
                isEnabled: false,
              ),
              TextInput(
                label: "*Economic",
                maxLength: 16,
                controller: TextEditingController(text: entity.economic),
                onChanged: (String value) => entity.economic = value,
              ),

              const SectionDivider(text: 'Truck details'),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child:
                    entity.internal != null ? _internalEditorFormBuilder(entity) : _externalEditorFormBuilder(entity),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onUpdate(TrailerCommon entity, Router router, BuildContext context) async {
    TrailersServiceI trucksService = Injector.get();

    List<EntityInvalidation<TrailerCommon>> invalidations = entity.evaluate();

    if (invalidations.isNotEmpty) {
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

    FoundationResponseResolver<UpdateOutput<TrailerCommon>> resResolver = await trucksService.update(
      UpdateInput<TrailerCommon>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      objectBuilder:
          () => UpdateOutput<TrailerCommon>(
            () => TrailerCommon(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<TrailerCommon>> success) {
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
              title: 'Error Updating Truck',
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

  Widget _externalEditorFormBuilder(TrailerCommon entity) {
    return Column(
      spacing: 10,
      children: <Widget>[
        TextInput(
          width: double.maxFinite,
          label: "*Carrier",
          maxLength: 100,
          controller: TextEditingController(text: entity.external?.carrier),
          onChanged: (String value) => entity.external?.carrier = value,
        ),
        TextInput(
          width: double.maxFinite,
          label: "USA Plate",
          maxLength: 7,
          controller: TextEditingController(text: entity.external?.usaPlate),
          onChanged: (String value) => entity.external?.usaPlate = value.cleaned,
        ),
        TextInput(
          width: double.maxFinite,
          label: "MX Plate",
          maxLength: 7,
          controller: TextEditingController(text: entity.external?.mxPlate ?? ''),
          onChanged: (String value) => entity.external?.mxPlate = value.cleaned,
        ),
      ],
    );
  }

  Widget _internalEditorFormBuilder(TrailerCommon entity) {
    List<String> countryOptions = FoundationCollections.kCountryList;
    List<String> usaStateOptions = FoundationCollections.kUStateCodes;
    List<String> mxStateOptions = FoundationCollections.kMXStateCodes;

    return Column(
      spacing: 10,
      children: <Widget>[
        EntityFinderSelector<Carrier, CarriersServiceI>(
          label: '*Carrier',
          initialValue: entity.internal?.carrier,
          textBuilder: (Carrier carrier) => carrier.name,
          entityBuilder: () => Carrier(),
          onSelected: (Carrier? carrier) {
            entity.internal?.carrier = carrier ?? Carrier();
          },
        ),

        EntityFinderSelector<Status, StatusesServiceI>(
          label: '*Status',
          initialValue: entity.status,
          textBuilder: (Status status) => status.name,
          entityBuilder: () => Status(),
          onSelected: (Status? status) {
            entity.status = status ?? Status();
            entity.internal?.sct?.status = status ?? Status();
            entity.internal?.maintenance?.status = status ?? Status();
            if (entity.internal?.model?.id == BigInt.zero) entity.internal?.model?.status = status ?? Status();
            for (Plate plate in entity.internal!.plates) {
              plate.status = status ?? Status();
            }
          },
        ),

        EntityFinderSelector<VehiculeModel, VehiculeModelsServiceI>(
          label: '*Model',
          initialValue: entity.internal?.model,
          textBuilder: (VehiculeModel model) => '${model.manufacturer.name} - ${model.name}',
          entityBuilder: () => VehiculeModel(),
          onSelected: (VehiculeModel? model) {
            entity.internal?.model = model ?? VehiculeModel();
          },
        ),

        EntityFinderSelector<Situation, SituationsServiceI>(
          label: 'Situation',
          initialValue: entity.situation,
          textBuilder: (Situation situation) => situation.name,
          entityBuilder: () => Situation(),
          onSelected: (Situation? situation) {
            entity.situation = situation;
          },
        ),

        EntityFinderSelector<Location, LocationsServiceI>(
          label: 'Location',
          initialValue: entity.location,
          textBuilder: (Location location) => location.name,
          entityBuilder: () => Location(),
          onSelected: (Location? location) {
            entity.location = location;
          },
        ),
        const SectionDivider(text: 'Plates details'),

        IncrementalList<Plate>(
          recordMin: 1,
          recordLimit: 2,
          modelBuilder: () => Plate(),
          recordList: entity.internal!.plates,
          onRemove: () {
            entity.internal!.plates.removeLast();
          },
          onAdd: (Plate model) {
            entity.internal!.plates.add(model);
          },
          recordBuilder: (Plate model, int index) {
            return Column(
              spacing: 10,
              children: <Widget>[
                SectionDivider(
                  text: "Plate ${index + 1}",
                ),
                TextInput(
                  label: "Identifier",
                  hint: "enter the plate identifier",
                  maxLength: 12,
                  controller: TextEditingController(
                    text: entity.internal!.plates.isNotEmpty ? entity.internal!.plates[index].identifier : null,
                  ),
                  onChanged: (String text) {
                    entity.internal!.plates[index].identifier = text;
                    entity.internal!.plates[index].status = entity.status;
                  },
                ),
                AutoCompleteField<String>(
                  width: double.maxFinite,
                  label: 'Country',
                  isOptional: true,
                  nativeList: FoundationCollections.kCountryList,
                  initialValue:
                      entity.internal!.plates.isEmpty || entity.internal!.plates[index].country == "" 
                          ? null
                          : entity.internal!.plates[index].country,
                  displayValue: (String? item) => item ?? "Not valid data",
                  onChanged: (String? text) {
                    Plate plate = entity.internal!.plates[index];
                    if(text != plate.country) entity.internal!.plates[index].state = null;
                    plate.country = text ?? '';
                    plate.status = entity.status;
                    _addressState.react();
                  },
                ),
                ReactiveWidget<_PlateState>(
                  reactor: _addressState,
                  builder: (BuildContext ctx, _PlateState state) {
                    String? currentCountry = entity.internal!.plates.isNotEmpty? entity.internal!.plates[index].country: null;
                    _addressEffect = state.react;
                    return AutoCompleteField<String>(
                      width: double.maxFinite,
                      label: '$currentCountry State',
                      suffixLabel: ' opt.',
                      isOptional: true,
                      isEnabled: currentCountry != '',
                      nativeList: currentCountry == countryOptions[0] ? usaStateOptions : mxStateOptions,
                      initialValue:
                          entity.internal!.plates.isEmpty || entity.internal!.plates[index].state == ""
                              ? null
                              : entity.internal!.plates[index].state,
                      displayValue: (String? item) => item ?? "Not valid data",
                      onChanged: (String? text) {
                        entity.internal!.plates[index].state = text.cleaned;
                        entity.internal!.plates[index].status = entity.status;
                      },
                    );
                  },
                ),
                Datepicker(
                  width: double.maxFinite,
                  firstDate: DateTime(1999),
                  lastDate: DateTime(2040),
                  label: "Expiration",
                  controller: TextEditingController(
                    text:
                        entity.internal!.plates.isNotEmpty ? entity.internal!.plates[index].expiration?.dateOnly : null,
                  ),
                  onChanged: (String text) {
                    entity.internal!.plates[index].expiration = DateTime.tryParse(text);
                    entity.internal!.plates[index].status = entity.status;
                  },
                ),
              ],
            );
          },
        ),

        if (entity.type != null)
          EntityFinderSelector<TrailerType, TrailerTypesServiceI>(
            label: 'Type',
            initialValue: entity.type,
            textBuilder: (TrailerType type) => "${type.trailerClass.name} - ${type.size}",
            entityBuilder: () => TrailerType(),
            onSelected: (TrailerType? location) {
              entity.type = location;
            },
          ),

        // Validate if the optional entities exist in current record, to show an appropiate layout.
        if (entity.internal?.maintenance != null) _maintenanceSection(entity),

        if (entity.internal?.sct != null) _sctSection(entity),

        if (entity.type == null) _typeSection(entity),

        if (entity.internal?.maintenance == null)
          FoldPanelWidget(
            title: "Add Maintenance details",
            child: _maintenanceSection(entity, isAdded: true),
          ),

        if (entity.internal?.sct == null)
          FoldPanelWidget(
            title: 'Add an SCT',
            child: _sctSection(entity, isAdded: true),
          ),
      ],
    );
  }

  Widget _typeSection(TrailerCommon entity, {bool isAdded = false}) {
    return ReactiveWidget<_TypeState>(
      reactor: _typeState,
      builder: (BuildContext ctx, _TypeState reactor) {
        return Column(
          spacing: 10,
          children: <Widget>[
            EntityFinderSelector<TrailerType, TrailerTypesServiceI>(
              label: 'Type',
              initialValue: entity.type?.id != BigInt.zero ? entity.type : null,
              textBuilder: (TrailerType type) => "${type.trailerClass.name} - ${type.size}",
              entityBuilder: () => TrailerType(),
              onSelected: (TrailerType? location) {
                entity.type = location;
              },
            ),
            FoldPanelWidget(
              title: 'Add Trailer type',
              child: Column(
                spacing: 10,
                children: <Widget>[
                  EntityFinderSelector<TrailerClass, TrailerClassesServiceI>(
                    label: 'Class',
                    initialValue: entity.type?.trailerClass,
                    enabled: entity.type?.id == BigInt.zero,
                    textBuilder: (TrailerClass trailerClass) => trailerClass.name,
                    entityBuilder: () => TrailerClass(),
                    onSelected: (TrailerClass? trailerClass) {
                      entity.type?.trailerClass = trailerClass ?? TrailerClass();
                    },
                  ),
                  TextInput(
                    label: "Size",
                    hint: "enter the plate identifier",
                    maxLength: 16,
                    isEnabled: entity.type?.id == BigInt.zero,
                    controller: TextEditingController(
                      text: entity.type?.size,
                    ),
                    onChanged: (String text) {
                      TrailerType? type = entity.type;
                      if (type != null && type.id != BigInt.zero) type.id = BigInt.zero;
                      type = type != null ? entity.type?.sanitize(size: text) : TrailerType().sanitize(size: text);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _sctSection(TrailerCommon entity, {bool isAdded = false}) {
    return Column(
      spacing: 10,
      children: <Widget>[
        const SectionDivider(text: 'SCT details'),

        TextInput(
          label: "*Type",
          hint: "Enter SCT type",
          maxLength: 6,
          isFixedLength: true,
          controller: TextEditingController(
            text: entity.internal?.sct?.type,
          ),
          onChanged: (String text) {
            SCT? sct = entity.internal?.sct;
            if (isAdded) {
              sct = sct != null ? sct.sanitize(type: text) : SCT().sanitize(type: text);
              return;
            }
            entity.internal?.sct?.type = text;
          },
        ),
        TextInput(
          label: "*Number",
          hint: "Enter SCT number",
          maxLength: 25,
          isFixedLength: true,
          controller: TextEditingController(
            text: entity.internal?.sct?.number,
          ),
          onChanged: (String text) {
            SCT? sct = entity.internal?.sct;
            if (isAdded) {
              sct = sct != null ? sct.sanitize(number: text) : SCT().sanitize(number: text);
              return;
            }
            entity.internal?.sct?.number = text;
          },
        ),
        TextInput(
          label: "*Configuration",
          hint: "Enter SCT config.",
          maxLength: 10,
          controller: TextEditingController(
            text: entity.internal?.sct?.configuration,
          ),
          onChanged: (String text) {
            SCT? sct = entity.internal?.sct;
            if (isAdded) {
              sct = sct != null ? sct.sanitize(configuration: text) : SCT().sanitize(configuration: text);
              return;
            }
            entity.internal?.sct?.configuration = text;
          },
        ),
      ],
    );
  }

  Widget _insuranceSection(TruckCommon entity, {bool isAdded = false}) {
    return Column(
      spacing: 10,
      children: <Widget>[
        TextInput(
          label: "Policy",
          hint: "*Enter the policy number",
          maxLength: 12,
          controller: TextEditingController(
            text: entity.internal?.insurance?.policy,
          ),
          onChanged: (String text) {
            Insurance? insurance = entity.internal?.insurance;
            if (isAdded) {
              insurance = insurance != null ? insurance.sanitize(policy: text) : Insurance().sanitize(policy: text);
              return;
            }
            entity.internal?.insurance?.policy = text;
          },
        ),
        AutoCompleteField<String>(
          width: double.maxFinite,
          label: '*Country',
          isOptional: true,
          nativeList: FoundationCollections.kCountryList,
          initialValue: entity.internal?.insurance?.country == "" ? null : entity.internal?.insurance?.country,
          displayValue: (String? item) => item ?? "Not valid data",
          onChanged: (String? text) {
            Insurance? insurance = entity.internal?.insurance;
            if (isAdded) {
              insurance =
                  insurance != null
                      ? insurance.sanitize(country: text ?? "")
                      : Insurance().sanitize(country: text ?? "");
              return;
            }
            entity.internal?.insurance?.country = text.cleaned ?? '';
          },
        ),
        Datepicker(
          width: double.maxFinite,
          firstDate: DateTime(1999),
          lastDate: DateTime(2040),
          label: "*Expiration",
          controller: TextEditingController(text: entity.internal?.insurance?.expiration.dateOnly),
          onChanged: (String text) {
            Insurance? insurance = entity.internal?.insurance;
            if (isAdded) {
              insurance =
                  insurance != null
                      ? insurance.sanitize(expiration: DateTime.tryParse(text) ?? DateTime(0))
                      : Insurance().sanitize(expiration: DateTime.tryParse(text) ?? DateTime(0));
              return;
            }
            entity.internal?.insurance?.expiration = DateTime.tryParse(text) ?? DateTime(0);
          },
        ),
      ],
    );
  }

  Widget _maintenanceSection(TrailerCommon entity, {bool isAdded = false}) {
    return Column(
      spacing: 10,
      children: <Widget>[
        const SectionDivider(text: 'Maintenance'),
        Datepicker(
          width: double.maxFinite,
          firstDate: DateTime(1940),
          lastDate: DateTime(2040),
          label: "*Anual maintenance",
          controller: TextEditingController(
            text: entity.internal?.maintenance?.anual.dateOnly,
          ),
          onChanged: (String text) {
            Maintenance? maintenance = entity.internal?.maintenance;
            if (isAdded) {
              maintenance =
                  maintenance != null
                      ? maintenance.sanitize(anual: DateTime.tryParse(text) ?? DateTime(0))
                      : Maintenance().sanitize(anual: DateTime.tryParse(text) ?? DateTime(0));
              return;
            }

            entity.internal?.maintenance?.anual = DateTime.tryParse(text) ?? DateTime(0);
          },
        ),
        Datepicker(
          width: double.maxFinite,
          firstDate: DateTime(1940),
          lastDate: DateTime(2040),
          label: "*Trimestral maintenance",
          controller: TextEditingController(
            text: entity.internal?.maintenance?.trimestral.dateOnly,
          ),
          onChanged: (String text) {
            Maintenance? maintenance = entity.internal?.maintenance;
            if (isAdded) {
              maintenance =
                  maintenance != null
                      ? maintenance.sanitize(trimestral: DateTime.tryParse(text) ?? DateTime(0))
                      : Maintenance().sanitize(trimestral: DateTime.tryParse(text));
              return;
            }
            entity.internal?.maintenance?.trimestral = DateTime.tryParse(text) ?? DateTime(0);
          },
        ),
      ],
    );
  }

  Widget _buildExternalDialog(TrailerCommon entity, Router router, BuildContext context) {
    return ResumeDialog(
      title: 'Confirm external trailer update',
      acceptLabel: 'Update',
      router: router,
      context: context,
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: "Economic",
          value: entity.economic,
        ),
        TextLabel(
          title: "Status",
          value: entity.status.name,
        ),
        TextLabel(
          title: "Type",
          value: entity.classType ?? '---',
        ),
        TextLabel(
          title: "Situation",
          value: entity.situation?.name ?? '---',
        ),
        TextLabel(
          title: "Location",
          value: entity.location?.name ?? '---',
        ),
        TextLabel(
          title: "USA Plates",
          value: entity.external?.usaPlate ?? '---',
        ),
        TextLabel(
          title: "MX Plates",
          value: entity.external?.mxPlate ?? '---',
        ),
        TextLabel(
          title: "Carrier",
          value: entity.external?.carrier ?? '---',
        ),
      ],
    );
  }

  Widget _buildInternalDialog(TrailerCommon entity, Router router, BuildContext context) {
    return ResumeDialog(
      acceptLabel: "Update",
      title: "Confirm trailer update",
      router: router,
      context: context,
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: "Economic",
          value: entity.economic,
        ),
        TextLabel(
          title: "Status",
          value: entity.status.name,
        ),
        TextLabel(
          title: "Situation",
          value: entity.situation?.name ?? '---',
        ),
        TextLabel(
          title: "Location",
          value: entity.location?.name ?? '---',
        ),
        TextLabel(
          title: "Plates",
          value: entity.plates ?? '---',
        ),
        TextLabel(
          title: "Type",
          value: entity.classType ?? '---',
        ),

        if (entity.internal?.sct != null) ...<TextLabel>[
          TextLabel(
            title: "SCT #",
            value: entity.internal?.sct?.number ?? '---',
          ),
          TextLabel(
            title: "SCT type",
            value: entity.internal?.sct?.type ?? '---',
          ),
          TextLabel(
            title: "SCT conf.",
            value: entity.internal?.sct?.configuration ?? '---',
          ),
        ],

        TextLabel(
          title: "Carrier",
          value: entity.internal?.carrier.name ?? '---',
        ),

        if (entity.internal?.maintenance != null) ...<TextLabel>[
          TextLabel(
            title: "Anual maintenance",
            value: entity.internal?.maintenance?.anual.dateOnly ?? '---',
          ),
          TextLabel(
            title: "Trim. maintenance",
            value: entity.internal?.maintenance?.trimestral.dateOnly ?? '---',
          ),
        ],

        TextLabel(
          title: "Model",
          value:
              entity.internal?.model != null
                  ? "${entity.internal?.model?.manufacturer.name} - ${entity.internal?.model?.name}"
                  : '---',
        ),

        for (int i = 0; i < entity.internal!.plates.length; i++) ...<TextLabel>[
          TextLabel(
            title: "${i + 1} - ${entity.internal?.plates[i].country} Plate",
            value: '',
          ),
          TextLabel(
            title: "Identifier",
            value: entity.internal?.plates[i].identifier ?? '---',
          ),
          TextLabel(
            title: "State",
            value: entity.internal?.plates[i].state ?? '---',
          ),
          TextLabel(
            title: "Expiration",
            value: entity.internal?.plates[i].expiration?.dateOnly ?? '---',
          ),
        ],
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [TrailerCommon] {entity}, also handles basic available behavior.
final class TrailersEntityTable extends FoundationEntityTableB<TrailersEntityTableAdapter> {
  /// Creates a new [TrailersEntityTable] instance.
  const TrailersEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<TrailerCommon, TrailersServiceI>(
      entityFactory: () => TrailerCommon(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<TrailerCommon>>[
        /// --> Economic column
        EntityTableColumnOptions<TrailerCommon>(
          title: 'Economic',
          factory: (TrailerCommon entity, int index, BuildContext buildContext) => entity.economic,
        ),
        EntityTableColumnOptions<TrailerCommon>(
          title: 'Ownership',
          factory:
              (TrailerCommon entity, int index, BuildContext buildContext) =>
                  entity.internal != null ? 'Own' : 'External',
        ),
        EntityTableColumnOptions<TrailerCommon>(
          title: 'Type',
          factory: (TrailerCommon entity, int index, BuildContext buildContext) => entity.classType ?? '---',
        ),
        EntityTableColumnOptions<TrailerCommon>(
          title: 'Status',
          factory: (TrailerCommon entity, int index, BuildContext buildContext) => entity.status.name,
        ),
        EntityTableColumnOptions<TrailerCommon>(
          title: 'Situation',
          factory: (TrailerCommon entity, int index, BuildContext buildContext) => entity.situation?.name ?? '---',
        ),
        EntityTableColumnOptions<TrailerCommon>(
          title: 'Location',
          factory: (TrailerCommon entity, int index, BuildContext buildContext) => entity.location?.name ?? '---',
        ),
        EntityTableColumnOptions<TrailerCommon>(
          title: 'Plates USA/MX',
          factory: (TrailerCommon entity, int index, BuildContext buildContext) => entity.plates,
        ),
      ],
    );
  }
}
