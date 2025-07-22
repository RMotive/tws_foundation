import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/interfaces/view_consume_adapter.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_datepicker_field.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_create_whisper_drivers_section.dart';
part '_create_whisper_drivers_externals_section.dart';
part '_adapters.dart';

/// Driver section state class.
final class _DriverSectionState extends ReactorB {}
final _DriverSectionState _driverSectionState = _DriverSectionState();
void Function() _driverSectionStateReact = (){};

/// {whisper} class.
final class DriversPageCreateWhisper extends PageB {
  /// Creates a new [DriversPageCreateWhisper] instance.
  const DriversPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return Whisper(
      title: 'Create Driver(s)',
      onPerform: () {},
      child:(GlobalKey<FormState> formState) {
        return CreateEntityForm<DriverCommon>(
          entityFactory: () => DriverCommon(),
          recordDesigner: (DriverCommon entity, bool selected, bool valid) {
            if(entity.internal != null) {
              return CreateEntityFormRecord(
                selected: selected,
                fields: <CreateEntityFormRecordField>[

                  /// --> Driver ownership type
                  CreateEntityFormRecordField(
                    label: 'Ownership',
                    value: entity.internal != null ? 'Own' : 'External',
                  ),
                  
                  /// --> Driver name
                  CreateEntityFormRecordField(
                    label: 'Name',
                    value: entity.internal?.employee.identification.name?? "---",
                  ),

                  /// --> Driver lastname
                  CreateEntityFormRecordField(
                    label: 'Lastname',
                    value: entity.internal?.employee.identification.lastName ?? "---",
                  ),

                  /// --> Driver Type
                  CreateEntityFormRecordField(
                    label: 'Type',
                    value: entity.internal?.driverType ?? "---",
                  ),

                  /// --> Driver License
                  CreateEntityFormRecordField(
                    label: 'License',
                    value: entity.license,
                  ),

                  /// --> License expiration date
                  CreateEntityFormRecordField(
                    label: 'License Expiration',
                    value: entity.internal?.licenseExpiration?.dateOnlyString ?? '---',
                  ),

                  /// --> Driver VISA number
                  CreateEntityFormRecordField(
                    label: 'VISA',
                    value: entity.internal?.visa ?? '---',
                  ),

                  /// --> Driver VISA expiration date
                  CreateEntityFormRecordField(
                    label: 'VISA Expiration',
                    value: entity.internal?.visaExpiration?.dateOnlyString ?? '---',
                  ),

                  /// --> Driver FAST number
                  CreateEntityFormRecordField(
                    label: 'FAST',
                    value: entity.internal?.fast ?? '---',
                  ),

                  /// --> Driver FAST expiration date
                  CreateEntityFormRecordField(
                    label: 'FAST Expiration',
                    value: entity.internal?.fastExpiration?.dateOnlyString ?? '---',
                  ),

                  /// --> Driver ANAM number
                  CreateEntityFormRecordField(
                    label: 'ANAM',
                    value: entity.internal?.anam ?? '---',
                  ),

                  /// --> Driver ANAM expiration date
                  CreateEntityFormRecordField(
                    label: 'ANAM Expiration',
                    value: entity.internal?.anamExpiration?.dateOnlyString ?? '---',
                  ),

                  /// --> Driver TWIC number
                  CreateEntityFormRecordField(
                    label: 'TWIC',
                    value: entity.internal?.twic ?? '---',
                  ),

                  /// --> Driver TWIC expiration date
                  CreateEntityFormRecordField(
                    label: 'TWIC Expiration',
                    value: entity.internal?.twicExpiration?.dateOnlyString ?? '---',
                  ),
                ],
              );
            }

            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField>[
                /// --> Driver ownership type
                CreateEntityFormRecordField(
                  label: 'Ownership',
                  value: 'External',
                ),
                
                /// --> Driver name
                CreateEntityFormRecordField(
                  label: 'Name',
                  value: entity.external?.identification.name ?? "---",
                ),

                /// --> Driver lastname
                CreateEntityFormRecordField(
                  label: 'Lastname',
                  value: entity.external?.identification.lastName ?? "---",
                ),

                /// --> Driver License
                CreateEntityFormRecordField(
                  label: 'License',
                  value: entity.license,
                ),

              ],
            );
            
          },
          formDesigner: (CreateEntityFormRecordReactor<DriverCommon>? itemState) {
            final bool formDisabled = !(itemState == null);
            if(formDisabled && itemState.entity.internal == null && itemState.entity.external == null) {
              itemState.entity.internal = Driver();
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
                          DriverCommon common = itemState!.entity;
                          if (selected.isNotEmpty && selected.first) {
                            common.internal = Driver();
                            common.external = null;
                          } else {
                            common.internal = null;
                            common.external = DriverExternal();
                          }
                          _driverSectionStateReact();
                          itemState.react();
                        },
                      ),
                    ),
                    TextInput(
                      width: double.maxFinite,
                      label: 'License',
                      isEnabled: formDisabled,
                      maxLength: 12,
                      controller: TextEditingController(
                        text: itemState?.entity.license,
                      ),
                      onChanged: (String text) {
                        DriverCommon common = itemState!.entity;
                        common.license = text;
                        itemState.react();
                      },
                    ),
                    Row(
                      spacing: 10,
                      children: <Expanded>[
                        Expanded(
                          child: EntityFinderSelector<Situation, SituationsServiceI>(
                            entityBuilder: () => Situation(),
                            label: 'Assing a situation...',
                            enabled:true,
                            initialValue: itemState?.entity.situation,
                            textBuilder: (Situation situation) {
                              return situation.name;
                            },
                            onSelected: (Situation? situation) {
                              itemState?.entity.situation = situation ?? Situation();
                              itemState?.react();
                            },
                          ), 
                        ),
                        Expanded(
                          child: EntityFinderSelector<Status, StatusesServiceI>(
                            entityBuilder: () => Status(),
                            label: 'Assing an status...',
                            enabled:true,
                            initialValue: itemState?.entity.status,
                            textBuilder: (Status status) {
                              return status.name;
                            },
                            onSelected: (Status? status) {
                              itemState?.entity.status = status ?? Status();
                              itemState?.react();
                            },
                          ), 
                        ),
                      ],
                    ),
                    TWSSectionDivider(
                      text: 'Driver Information',
                    ),
                    // --> Driver edge Section
                    ReactiveWidget<_DriverSectionState>(
                      reactor: _driverSectionState,
                      builder: (BuildContext ctx, _DriverSectionState reactor) {
                        _driverSectionStateReact = reactor.react;
                        return itemState?.entity.external != null? 
                          _CreateWhisperDriversExternalsSection(
                            itemState: itemState,
                            isDisabled: formDisabled,
                          ) : _CreateWhisperDriversSection(
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
