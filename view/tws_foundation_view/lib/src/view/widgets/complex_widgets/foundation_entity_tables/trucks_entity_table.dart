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
import 'package:tws_foundation_view/src/view/widgets/incremental_list.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


/// Address state class.
class _PlateState extends ReactorB {}

_PlateState _addressState = _PlateState();
// ignore: unused_element
void Function() _addressEffect = () {};

/// {adapter} class.
/// 
/// implements the [FoundationEntityTableAdapterB] for [TruckCommon] entities.
final class TrucksEntityTableAdapter extends FoundationEntityTableAdapterB<TruckCommon> {
  TrucksEntityTableAdapter({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, TruckCommon entity) {
    List<Widget> scopeColumn = <Widget>[];
    if (entity.internal != null){
      scopeColumn = <Widget>[
        const SectionDivider(text: 'Truck details'),
        PropertyViewer(
          label: 'Motor',
          value: entity.internal?.motor ?? '---',
        ),
        PropertyViewer(
          label: 'Vin',
          value: entity.internal?.vin,
        ),
        PropertyViewer(
          label: 'SCT',
          value: entity.internal?.sct?.number ?? '---',
        ),

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
          value: entity.internal?.model.name ?? '---',
        ),
        PropertyViewer(
          label: 'Manufacturer',
          value: entity.internal?.model.manufacturer.name ?? '---',
        ),

        const SectionDivider(text: 'Insurance details'),

        PropertyViewer(
          label: 'Insurance policy',
          value: entity.internal?.insurance?.policy ?? '---',
        ),
        PropertyViewer(
          label: 'Insurance country',
          value: entity.internal?.insurance?.country ?? '---',
        ),
        PropertyViewer(
          label: 'Insurance expiration',
          value: entity.internal?.insurance?.expiration.dateOnly ?? '---',
        ),
        for(int i = 0; i < entity.internal!.plates.length; i++)
          ...<Widget>[
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

    if(entity.external != null){
      scopeColumn = <Widget>[
        PropertyViewer(
          label: 'Vin',
          value: entity.external?.vin ?? '---',
        ),
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
            value: entity.internal != null ? 'Own' : entity.external != null ? 'External' : '---',
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
            label: 'Situation',
            value: entity.situation?.name ?? '---',
          ),
          PropertyViewer(
            label: 'Location',
            value: entity.location?.name ?? '---',
          ),

          ...scopeColumn,
        ]
      ),
    );
  }

  @override
  EntityTableAdapterEditor<TruckCommon>? composeEditor() {
    return EntityTableAdapterEditor<TruckCommon>(
      onUpdate: (BuildContext buildContext, TruckCommon entity) {
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
      formBuilder:(BuildContext buildContext, TruckCommon entity) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 10,
            children: <Widget>[
              const SectionDivider(text: 'Common details'),
              
              TextInput(
                label: "TimeStamp",
                controller: TextEditingController(
                  text: entity.timestamp.toString()
                ),
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
                child: entity.internal != null? _internalEditorFormBuilder(entity) : _externalEditorFormBuilder(entity),
              )
              
            ],
          ),
        );
      },
    );
  }
  void _onUpdate(TruckCommon entity, Router router, BuildContext context) async {
    TrucksServiceI trucksService = Injector.get();

    List<EntityInvalidation<TruckCommon>> invalidations = entity.evaluate();

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

    FoundationResponseResolver<UpdateOutput<TruckCommon>> resResolver = await trucksService.update(
      UpdateInput<TruckCommon>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      objectBuilder:
          () => UpdateOutput<TruckCommon>(
            () => TruckCommon(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<TruckCommon>> success) {
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

  Widget _externalEditorFormBuilder(TruckCommon entity){
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
          label: "VIN",
          maxLength: 7,
          controller: TextEditingController(text: entity.external?.vin),
          onChanged: (String value) => entity.external?.vin = value.cleaned,
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

  Widget _internalEditorFormBuilder(TruckCommon entity) {
    List<String> countryOptions = FoundationCollections.kCountryList;
    List<String> usaStateOptions = FoundationCollections.kUStateCodes;
    List<String> mxStateOptions = FoundationCollections.kMXStateCodes;

    return Column(
      spacing: 10,
      children: <Widget>[
        TextInput(
          width: double.maxFinite,
          label: "*Vin",
          maxLength: 17,
          controller: TextEditingController(text: entity.internal?.vin),
          onChanged: (String value) => entity.internal?.vin = value,
        ),
        TextInput(
          width: double.maxFinite,
          label: "Motor",
          maxLength: 16,
          controller: TextEditingController(text: entity.internal?.motor),
          onChanged: (String value) => entity.internal?.motor = value.cleaned,
        ),

        EntityFinderSelector<Carrier, CarriersServiceI>(
          label: '*Carrier',
          initialValue: entity.internal?.carrier,
          textBuilder:(Carrier carrier) => carrier.name,
          entityBuilder: () => Carrier(),
          onSelected: (Carrier? carrier) {
            entity.internal?.carrier = carrier ?? Carrier();
          },
        ),
    
        EntityFinderSelector<Status, StatusesServiceI>(
          label: '*Status',
          initialValue: entity.status,
          textBuilder:(Status status) => status.name,
          entityBuilder: () => Status(),
          onSelected: (Status? status) {
            entity.status = status ?? Status();
            entity.internal?.sct?.status = status ?? Status();
            entity.internal?.insurance?.status = status ?? Status();
            entity.internal?.maintenance?.status = status ?? Status();
            for (Plate plate in entity.internal!.plates) {
              plate.status = status ?? Status();
            }
          },
        ),
    
        EntityFinderSelector<VehiculeModel, VehiculeModelsServiceI>(
          label: '*Model',
          initialValue: entity.internal?.model,
          textBuilder:(VehiculeModel model) => '${model.manufacturer.name} - ${model.name}',
          entityBuilder: () => VehiculeModel(),
          onSelected: (VehiculeModel? model) {
            entity.internal?.model = model ?? VehiculeModel();
          },
        ),
    
        EntityFinderSelector<Situation, SituationsServiceI>(
          label: 'Situation',
          initialValue: entity.situation,
          textBuilder:(Situation situation) => situation.name,
          entityBuilder: () => Situation(),
          onSelected: (Situation? situation) {
            entity.situation = situation;
          },
        ),
    
         EntityFinderSelector<Location, LocationsServiceI>(
          label: 'Location',
          initialValue: entity.location,
          textBuilder:(Location location) => location.name,
          entityBuilder: () => Location(),
          onSelected: (Location? location) {
            entity.location = location;
          },
        ),
        const SectionDivider(text: 'Plates details'),

        IncrementalList<Plate>(
          recordMin: 1,
          recordLimit: 2,
          modelBuilder:() => Plate(),
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
                    text: entity.internal!.plates[index].identifier,
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
                      entity.internal!.plates[index].country == "" ? null : entity.internal!.plates[index].country,
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
                    String? currentCountry = entity.internal!.plates[index].country;
                    _addressEffect = state.react;
                    return AutoCompleteField<String>(
                      width: double.maxFinite,
                      label: '$currentCountry State',
                      suffixLabel: ' opt.',
                      isOptional: true,
                      isEnabled: currentCountry != '',
                      nativeList: currentCountry == countryOptions[0] ? usaStateOptions : mxStateOptions,
                      initialValue:
                          entity.internal!.plates[index].state == "" ? null : entity.internal!.plates[index].state,
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
                  controller: TextEditingController(text: entity.internal!.plates[index].expiration?.dateOnly),
                  onChanged: (String text) {
                    entity.internal!.plates[index].expiration = DateTime.tryParse(text);
                    entity.internal!.plates[index].status = entity.status;
                  },
                ),
              ],
            );
          },
        ),
    
        // Validate if the optional entities exist in current record, to show an appropiate layout.
        if(entity.internal?.maintenance != null)
        _maintenanceSection(entity),
    
        if(entity.internal?.insurance != null)
        _insuranceSection(entity),
    
        if(entity.internal?.sct != null)
        _sctSection(entity),
    
        if(entity.internal?.maintenance == null)
          FoldPanelWidget(
            title: "Add Maintenance details",
            child: _maintenanceSection(entity, isAdded: true),
          ),
    
        if(entity.internal?.insurance == null)
          FoldPanelWidget(
            title: 'Add Insurance details',
            child: _insuranceSection(entity, isAdded: true),
          ),
    
        if(entity.internal?.sct == null)
          FoldPanelWidget(
            title: 'Add an SCT',
            child: _sctSection(entity, isAdded: true),
          ),
      ],
    );
  }

  Widget _sctSection(TruckCommon entity, {bool isAdded = false}){
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
            if(isAdded){
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
            if(isAdded){
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
            if(isAdded){
              sct = sct != null ? sct.sanitize(configuration: text) : SCT().sanitize(configuration: text);
              return;
            }
            entity.internal?.sct?.configuration = text;
          },
        ),
      ],
    );
  }

  Widget _insuranceSection(TruckCommon entity, {bool isAdded = false}){
    return Column(
      spacing: 10,
      children: <Widget>[
        const SectionDivider(text: 'Insurance details'),
        TextInput(
          label: "Policy",
          hint: "*Enter the policy number",
          maxLength: 20,
          controller: TextEditingController(
            text: entity.internal?.insurance?.policy,
          ),
          onChanged: (String text) {
            Insurance? insurance = entity.internal?.insurance;
            if(isAdded){
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
          initialValue:
              entity.internal?.insurance?.country == "" ? null : entity.internal?.insurance?.country,
          displayValue: (String? item) => item ?? "Not valid data",
          onChanged: (String? text) {
            Insurance? insurance = entity.internal?.insurance;
            if(isAdded){
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
            if(isAdded){
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

  Widget _maintenanceSection(TruckCommon entity, {bool isAdded = false}){
    return Column(
      spacing: 10,
      children: <Widget>[
        const SectionDivider(text: 'Maintenance details'),
        Datepicker(
          width: double.maxFinite,
          firstDate: DateTime(1940),
          lastDate: DateTime(2040),
          label: "*Anual maintenance",
          controller: TextEditingController(
            text: entity.internal?.maintenance?.anual.dateOnly,
          ),
          onChanged: (String text) {
            Maintenance? maintenance =  entity.internal?.maintenance;
            if(isAdded){
              maintenance = maintenance != null
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
            Maintenance? maintenance =  entity.internal?.maintenance;
            if(isAdded){
             maintenance = maintenance != null
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
  
  Widget _buildExternalDialog(TruckCommon entity, Router router, BuildContext context) { 
    return ResumeDialog(
      title: 'Confirm external truck update',
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
        TextLabel(
          title: "Vin",
          value: entity.external?.vin ?? '---',
        ),
      ],
    );

  }

  Widget _buildInternalDialog(TruckCommon entity, Router router, BuildContext context) {
    return ResumeDialog(
      acceptLabel: "Update",
      title: "Confirm truck update",
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
          title: "Vin",
          value: entity.internal?.vin ?? '---',
        ),
        TextLabel(
          title: "Motor",
          value: entity.internal?.motor ?? '---',
        ),

        if(entity.internal?.sct != null) ...<TextLabel>[
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

        if(entity.internal?.maintenance != null) ...<TextLabel>[
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
                  ? "${entity.internal?.model.manufacturer.name} - ${entity.internal?.model.name}"
                  : '---',
        ),

        if(entity.internal?.insurance != null) ...<TextLabel>[
          TextLabel(
            title: "Insurance policy",
            value: entity.internal?.insurance?.policy ?? '---',
          ),
          TextLabel(
            title: "Insurance country",
            value: entity.internal?.insurance?.country ?? '---',
          ),
          TextLabel(
            title: "Insurance expiration",
            value: entity.internal?.insurance?.expiration.dateOnly ?? '---',
          ),
        ],
        

        for(int i = 0; i < entity.internal!.plates.length; i++)
          ...<TextLabel>[
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
/// Draws a {foundation} complex [EntityTable] based on [TruckCommon] {entity}, also handles basic available behavior.
final class TrucksEntityTable extends FoundationEntityTableB<TrucksEntityTableAdapter> {
  /// Creates a new [TrucksEntityTable] instance.
  const TrucksEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<TruckCommon, TrucksServiceI>(
      entityFactory: () => TruckCommon(),
      ranges: <int>[3],
      adapter: adapter,
      columns: <EntityTableColumnOptions<TruckCommon>>[
        /// --> Economic column
        EntityTableColumnOptions<TruckCommon>(
          title: 'Economic',
          factory: (TruckCommon entity, int index, BuildContext buildContext) => entity.economic,
        ),
        EntityTableColumnOptions<TruckCommon>(
          title: 'Ownership',
          factory: (TruckCommon entity, int index, BuildContext buildContext) => entity.internal != null? 'Own' : 'External',
        ),
        EntityTableColumnOptions<TruckCommon>(
          title: 'Status',
          factory: (TruckCommon entity, int index, BuildContext buildContext) => entity.status.name,
        ),
        EntityTableColumnOptions<TruckCommon>(
          title: 'Situation',
          factory: (TruckCommon entity, int index, BuildContext buildContext) => entity.situation?.name ?? '---',
        ),
        EntityTableColumnOptions<TruckCommon>(
          title: 'Location',
          factory: (TruckCommon entity, int index, BuildContext buildContext) => entity.location?.name ?? '---',
        ),
        EntityTableColumnOptions<TruckCommon>(
          title: 'Plates',
          factory: (TruckCommon entity, int index, BuildContext buildContext) => entity.plates,
        ),
        
        
      ],
    );
  }
}