
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

part 'create_internal_trailer/_create_whisper_trailers_section.dart';
part 'create_internal_trailer/_create_whisper_plates_section.dart';
part 'create_internal_trailer/_create_whisper_model_section.dart';
part 'create_internal_trailer/_create_whisper_sct_section.dart';
part 'create_internal_trailer/_create_whisper_maintenance_section.dart';
part 'create_internal_trailer/_create_whisper_type_section.dart';

part '_create_whisper_trailer_external_section.dart';

/// Driver section state class.
final class _TrailerSectionState extends ReactorB {}
final _TrailerSectionState _trailerSectionState = _TrailerSectionState();
void Function() _trailerSectionStateReact = (){};

Status _defaultStatus = Status();

///  --> Addresses const information.
const List<String> _countries = FoundationCollections.kCountryList;
const List<String> _statesUSA = FoundationCollections.kUStateCodes;
const List<String> _statesMX = FoundationCollections.kMXStateCodes;

/// {whisper} class.
final class TrailersPageCreateWhisper extends PageB {
  /// Creates a new [TrailersPageCreateWhisper] instance.
  const TrailersPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();

    return Whisper(
      title: 'Create Trailer(s)',
      onPerform: () {
        creationController.create();
      },
      child:(GlobalKey<FormState> formState) {
        return CreateEntityForm<TrailerCommon, TrailersServiceI>(
          entityFactory: () => TrailerCommon(),
          controller: creationController,
          buildEntityTag: (TrailerCommon entity) {
            return 'Trailer with number: ${entity.economic}';
          },
          onCreate: (List<TrailerCommon> entities) {
            List<UserFeedback> feedbacks = <UserFeedback>[];
            List<EntityInvalidation<TrailerCommon>> invalidations = <EntityInvalidation<TrailerCommon>>[];

            for(TrailerCommon entity in entities){
              invalidations.addAll(entity.evaluate());
            }

            if(invalidations.isNotEmpty){
              for(EntityInvalidation<TrailerCommon> invalidation in invalidations){
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
          recordDesigner: (TrailerCommon entity, bool selected, bool valid) {
            List<CreateEntityFormRecordField> commonFields = <CreateEntityFormRecordField>[
              /// --> Trailer ownership type
              CreateEntityFormRecordField(
                label: 'Ownership',
                value: entity.internal != null? 'Own' : 'Internal',
              ),

              /// --> Trailer Economic type.
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

              /// --> Trailer type and size.
              if (entity.type != null)
                CreateEntityFormRecordField(
                  label: 'Type',
                  value: entity.classType ?? '---',
                ),
            ];

            if(entity.internal != null) {
              return CreateEntityFormRecord(
                selected: selected,
                fields: <CreateEntityFormRecordField>[
                  /// --> Adding common fields.
                  ...commonFields,
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
                      value: entity.internal!.model?.manufacturer.name.cleaned ?? "---",
                    ),

                    /// --> Truck model name.
                    CreateEntityFormRecordField(
                      label: '*Model',
                      value: entity.internal!.model?.name.cleaned ?? '---',
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
          formDesigner: (CreateEntityFormRecordReactor<TrailerCommon>? itemState) {
            final bool formDisabled = !(itemState == null);
            if(formDisabled && itemState.entity.internal == null && itemState.entity.external == null) {
              itemState.entity.internal = Trailer();
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
                          TrailerCommon common = itemState!.entity;
                          if (selected.isNotEmpty && selected.first) {
                            common.internal = Trailer();
                            common.external = null;
                          } else {
                            common.internal = null;
                            common.external = TrailerExternal();
                          }
                          _trailerSectionStateReact();
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
                              Trailer? internal = itemState?.entity.internal;
                              // Setting default status values, only for unique entities.
                              itemState?.entity.status = _defaultStatus;
                              internal?.sct?.status = _defaultStatus;
                              internal?.maintenance?.status = _defaultStatus;
                              if(itemState?.entity.type?.id == BigInt.zero) itemState?.entity.type?.status = _defaultStatus;

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
                      text: '*Trailer Information',
                    ),
                    //--> Driver edge Section
                    ReactiveWidget<_TrailerSectionState>(
                      reactor: _trailerSectionState,
                      builder: (BuildContext ctx, _TrailerSectionState reactor) {
                        _trailerSectionStateReact = reactor.react;
                        return itemState?.entity.internal != null? 
                          _CreateWhisperTrailersSection(
                            itemState: itemState,
                            isEnabled: formDisabled,
                          ) : _CreateWhisperTrailersExternalSection(
                            itemState: itemState,
                            isEnabled: formDisabled,
                          );
                      },
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
