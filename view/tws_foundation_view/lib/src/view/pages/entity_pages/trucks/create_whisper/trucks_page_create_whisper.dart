import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/user_feedback.dart';
import 'package:tws_foundation_view/src/data/const/static_collections.dart';
import 'package:tws_foundation_view/src/view/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_datepicker_field.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_incremental_list.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


part '_create_whisper_trucks_externals_section.dart';
part 'create_internal_truck/_create_whisper_trucks_internal_section.dart';
part 'create_internal_truck/_create_whisper_sct_section.dart';
part 'create_internal_truck/_create_whisper_model_section.dart';
part 'create_internal_truck/_create_whisper_plates_section.dart';
part 'create_internal_truck/_create_whisper_insurance_section.dart';
part 'create_internal_truck/_create_whisper_maintenance_section.dart';

/// Driver section state class.
final class _TruckSectionState extends ReactorB {}
final _TruckSectionState _truckSectionState = _TruckSectionState();
void Function() _truckSectionStateReact = (){};

Status _defaultStatus = Status();

///  --> Addresses const information.
const List<String> _countries = FoundationCollections.kCountryList;
const List<String> _statesUSA = FoundationCollections.kUStateCodes;
const List<String> _statesMX = FoundationCollections.kMXStateCodes;

/// {whisper} class.
final class TrucksPageCreateWhisper extends PageB {
  /// Creates a new [TrucksPageCreateWhisper] instance.
  const TrucksPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Whisper(
      title: 'Create Truck(s)',
      onPerform: () {
        print('perform');
      },
      child:(GlobalKey<FormState> formState) {
        return CreateEntityForm<TruckCommon>(
          entityFactory: () => TruckCommon(),
          onCreate: (List<TruckCommon> entities) {
            List<UserFeedback> feedbacks = <UserFeedback>[];
            List<EntityInvalidation<TruckCommon>> invalidations = <EntityInvalidation<TruckCommon>>[];

            for(TruckCommon entity in entities){
              invalidations.addAll(entity.evaluate());
            }

            if(invalidations.isNotEmpty){
              for(EntityInvalidation<TruckCommon> invalidation in invalidations){
                UserFeedback feedback = UserFeedback(
                  type: UserFeedbackType.error,
                  message: invalidation.reason,
                );
                feedbacks.add(feedback);
              }
              return feedbacks;
            }

            return feedbacks;
          },
          recordDesigner: (TruckCommon entity, bool selected, bool valid) {
            List<CreateEntityFormRecordField> commonFields = <CreateEntityFormRecordField>[
              /// --> Truck ownership type
              CreateEntityFormRecordField(
                label: 'Ownership',
                value: entity.internal != null? 'Own' : 'Internal',
              ),

              /// --> Truck ownership type.
              CreateEntityFormRecordField(
                label: '*Economic',
                value: entity.economic.cleaned ?? '---',
              ),

              /// --> Truck Status
              CreateEntityFormRecordField(
                label: '*Status',
                value: entity.status.name.cleaned ?? '---',
              ),

              /// --> Truck Situation
              CreateEntityFormRecordField(
                label: 'Situation',
                value: entity.situation?.name ?? "---",
              ),

                /// --> Truck location
              CreateEntityFormRecordField(
                label: 'Location',
                value: entity.location?.name ?? "---",
              ),
            ];

            if(entity.internal != null) {
              return CreateEntityFormRecord(
                selected: selected,
                fields: <CreateEntityFormRecordField>[
                  /// --> Adding common fields.
                  ...commonFields,

                  /// --> Truck Motor number.
                  CreateEntityFormRecordField(
                    label: '*Vin #',
                    value: entity.internal!.vin.cleaned ?? '---',
                  ),

                  /// --> Truck Motor number.
                  CreateEntityFormRecordField(
                    label: 'Motor #',
                    value: entity.internal!.motor ?? '---',
                  ),

                  /// --> Truck carrier name.
                  CreateEntityFormRecordField(
                    label: '*Carrier',
                    value: entity.internal!.carrier.name.cleaned ?? "---",
                  ),

                  /// --> Truck Plates.
                  for (int i = 0; i < entity.internal!.plates.length; i++) ...<CreateEntityFormRecordField>[
                    CreateEntityFormRecordField(
                      label: 'Plate ${i + 1}',
                      minWidth: 150,
                      value:
                          '${entity.internal!.plates[i].country.cleaned ?? "---"} - ${entity.internal!.plates[i].identifier}',
                    ),
                  ],

                  if(entity.internal?.model != null) ...<CreateEntityFormRecordField>[
                    /// --> Truck manufacturer name.
                    CreateEntityFormRecordField(
                      label: '*Manufacturer',
                      value: entity.internal!.model.manufacturer.name.cleaned ?? "---",
                    ),

                    /// --> Truck model name.
                    CreateEntityFormRecordField(
                      label: '*Model',
                      value: entity.internal!.model.name.cleaned ?? '---',
                    ),
                  ],

                  if(entity.internal?.sct != null) ...<CreateEntityFormRecordField>[ 
                    /// --> Truck SCT type.
                    CreateEntityFormRecordField(
                      label: '*SCT Type',
                      value: entity.internal!.sct?.type.cleaned ?? '---',
                    ),

                    /// --> Truck SCT number.
                    CreateEntityFormRecordField(
                      label: '*SCT number',
                      value: entity.internal!.sct?.number.cleaned ?? '---',
                    ),
                    
                    /// --> Truck SCT type.
                    CreateEntityFormRecordField(
                      label: '*SCT configuration',
                      value: entity.internal!.sct?.configuration.cleaned ?? '---',
                    ),
                  ],

                  if(entity.internal?.maintenance != null) ...<CreateEntityFormRecordField>[
                    /// --> Truck maintenance anual.
                    CreateEntityFormRecordField(
                      label: '*Anual maintenance',
                      value: entity.internal!.maintenance?.anual.dateOnly ?? '---',
                    ),

                    /// --> Truck maintenance trimestral.
                    CreateEntityFormRecordField(
                      label: '*Trimestral maintenance',
                      value: entity.internal!.maintenance?.trimestral.dateOnly ?? '---',
                    ),
                  ],

                  if(entity.internal?.insurance != null) ...<CreateEntityFormRecordField>[
                    /// --> Truck insurance policy.
                    CreateEntityFormRecordField(
                      label: '*Insurance Policy',
                      value: entity.internal!.insurance?.policy ?? '---',
                    ),
                    
                    /// --> Truck insurance country.
                    CreateEntityFormRecordField(
                      label: '*Insurance country',
                      value: entity.internal!.insurance?.country ?? '---',
                    ),

                    /// --> Truck insurance expiration.
                    CreateEntityFormRecordField(
                      label: '*Insurance expiration',
                      value: entity.internal!.insurance?.expiration.dateOnly ?? '---',
                    ),
                  ],
                ],
              );
            }

            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField>[
                /// --> Adding common fields.
                ...commonFields,

                /// --> Driver carrier name.
                CreateEntityFormRecordField(
                  label: '*Carrier',
                  value: entity.external!.carrier.cleaned ?? '---',
                ),

                /// --> Driver vin numbger.
                CreateEntityFormRecordField(
                  label: 'Vin #',
                  value: entity.external!.vin ?? '---',
                ),

                /// --> Driver USA plate.
                CreateEntityFormRecordField(
                  label: 'USA Plate',
                  value: entity.external!.usaPlate ?? '---',
                ),

                /// --> Driver MX plate.
                CreateEntityFormRecordField(
                  label: 'MX Plate',
                  value: entity.external!.mxPlate ?? '---',
                ),
              ],
            );
            
          },
          formDesigner: (CreateEntityFormRecordReactor<TruckCommon>? itemState) {
            final bool formDisabled = !(itemState == null);
            if(formDisabled && itemState.entity.internal == null && itemState.entity.external == null) {
              itemState.entity.internal = Truck();
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  children: <Widget>[
                    /// --> Ownership Type
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: OptionsSelector<bool>(
                        title: 'Ownership',
                        preSelected: <bool>[
                          itemState?.entity.external != null ? false : true,
                        ],
                        options: <OptionsSelectorOption<bool>>[
                          OptionsSelectorOption<bool>(
                            title: 'Own',
                            value: true,
                          ),
                          OptionsSelectorOption<bool>(
                            title: 'External',
                            value: false,
                          ),
                        ],
                        onSelect: (List<bool> selected) {
                          TruckCommon common = itemState!.entity;
                          if (selected.isNotEmpty && selected.first) {
                            common.internal = Truck();
                            common.external = null;
                          } else {
                            common.internal = null;
                            common.external = TruckExternal();
                          }
                          _truckSectionStateReact();
                          itemState.react();
                        },
                      ),
                    ),
                    Row(
                      spacing: 10,
                      children: <Widget>[
                        Expanded(
                          child: TextInput(
                            label: '*Economic',
                            isEnabled: formDisabled,
                            maxLength: 16,
                            controller: TextEditingController(
                              text: itemState?.entity.economic,
                            ),
                            onChanged: (String text) {
                              itemState!.entity.economic = text;
                              itemState.react();
                            },
                          ),
                        ),
                        Expanded(
                          child: EntityFinderSelector<Status, StatusesServiceI>(
                            entityBuilder: () => Status(),
                            label: '*Assing an status...',
                            enabled:true,
                            initialValue: itemState?.entity.status,
                            textBuilder: (Status status) {
                              return status.name;
                            },
                            onSelected: (Status? status) {
                              _defaultStatus = status ?? Status();
                              Truck? internal = itemState?.entity.internal;
                              itemState?.entity.status = _defaultStatus;
                              // Setting default status values
                              internal?.sct?.status = _defaultStatus;
                              internal?.insurance?.status = _defaultStatus;
                              internal?.maintenance?.status = _defaultStatus;
                              if (internal!.model.id == BigInt.zero) internal.model.status = _defaultStatus;

                              for (Plate plate in itemState!.entity.internal!.plates) {
                                plate.status = _defaultStatus;
                              }
                              itemState.react();
                            },
                          ), 
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: <Expanded>[
                        Expanded(
                          child: EntityFinderSelector<Location, LocationsServiceI>(
                            entityBuilder: () => Location(),
                            label: 'Assing a location...',
                            enabled:true,
                            initialValue: itemState?.entity.location,
                            textBuilder: (Location location) {
                              return location.name.cleaned ?? '---';
                            },
                            onSelected: (Location? location) {
                              itemState?.entity.location = location ?? Location();
                              itemState?.react();
                            },
                          ), 
                        ),
                        Expanded(
                          child: EntityFinderSelector<Situation, SituationsServiceI>(
                            entityBuilder: () => Situation(),
                            label: 'Assing a situation...',
                            enabled:true,
                            initialValue: itemState?.entity.situation,
                            textBuilder: (Situation situation) {
                              return situation.name.cleaned ?? '---';
                            },
                            onSelected: (Situation? situation) {
                              itemState?.entity.situation = situation ?? Situation();
                              itemState?.react();
                            },
                          ), 
                        ),
                      ],
                    ),
                    const SectionDivider(
                      text: '*Truck Information',
                    ),
                    // --> Driver edge Section
                    ReactiveWidget<_TruckSectionState>(
                      reactor: _truckSectionState,
                      builder: (BuildContext ctx, _TruckSectionState reactor) {
                        _truckSectionStateReact = reactor.react;
                        return itemState?.entity.internal != null? 
                          _CreateWhisperTrucksSection(
                            itemState: itemState,
                            isEnabled: formDisabled,
                          ) : _CreateWhisperTrucksExternalSection(
                            itemState: itemState,
                            isEnabled: formDisabled,
                          );
                      },
                    )
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
