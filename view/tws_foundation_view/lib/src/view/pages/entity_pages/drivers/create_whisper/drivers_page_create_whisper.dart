import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/interfaces/view_consume_adapter.dart';
import 'package:tws_foundation_view/src/core/models/user_feedback.dart';
import 'package:tws_foundation_view/src/data/const/static_collections.dart';
import 'package:tws_foundation_view/src/view/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_datepicker_field.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part 'create_internal_driver/_create_whisper_drivers_section.dart';
part 'create_internal_driver/_create_whisper_employee_section.dart';
part 'create_internal_driver/_create_whisper_address_section.dart';
part 'create_internal_driver/_create_whisper_approach_section.dart';

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
      onPerform: () {
        print('perform');
      },
      child:(GlobalKey<FormState> formState) {
        return CreateEntityForm<DriverCommon>(
          entityFactory: () => DriverCommon(),
          onCreate: (List<DriverCommon> entities) {
            List<UserFeedback> feedbacks = <UserFeedback>[];
            List<EntityInvalidation<DriverCommon>> invalidations = <EntityInvalidation<DriverCommon>>[];

            for(DriverCommon entity in entities){
              invalidations.addAll(entity.evaluate());
            }

            if(invalidations.isNotEmpty){
              for(EntityInvalidation<DriverCommon> invalidation in invalidations){
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
                    label: '*Name',
                    value: entity.internal?.employee.identification.name ?? "---",
                  ),

                  /// --> Driver lastname
                  CreateEntityFormRecordField(
                    label: '*Lastname',
                    value: entity.internal?.employee.identification.lastName ?? "---",
                  ),

                  /// --> Driver License
                  CreateEntityFormRecordField(
                    label: '*License',
                    value: entity.license,
                  ),

                  /// --> Driver Situation
                  CreateEntityFormRecordField(
                    label: '*Situation',
                    value: entity.situation.name.isEmpty ? "---" : entity.situation.name,
                  ),

                  /// --> Driver Status
                  CreateEntityFormRecordField(
                    label: '*Status',
                    value: entity.status.name.isEmpty ? "---" : entity.situation.name,
                  ),

                  /// --> Driver Type
                  if(entity.internal?.driverType != null)
                  CreateEntityFormRecordField(
                    label: 'Type',
                    value: entity.internal!.driverType.cleaned ?? '---',
                  ),

                  /// --> License expiration date
                  if(entity.internal?.licenseExpiration != null)
                  CreateEntityFormRecordField(
                    label: 'License Expiration',
                    value: entity.internal?.licenseExpiration?.dateOnlyString ?? '---',
                  ),

                  /// --> Driver VISA number
                  if(entity.internal?.visa != null)
                  CreateEntityFormRecordField(
                    label: 'VISA',
                    value: entity.internal!.visa ?? '---',
                  ),

                  /// --> Driver VISA expiration date
                  if(entity.internal?.visaExpiration != null)
                  CreateEntityFormRecordField(
                    label: 'VISA Expiration',
                    value: entity.internal?.visaExpiration?.dateOnlyString ?? '---',
                  ),

                  /// --> Driver FAST number
                   if(entity.internal?.fast != null)
                  CreateEntityFormRecordField(
                    label: 'FAST',
                    value: entity.internal!.fast ?? '---',
                  ),

                  /// --> Driver FAST expiration date
                  if(entity.internal?.fastExpiration != null)
                  CreateEntityFormRecordField(
                    label: 'FAST Expiration',
                    value: entity.internal?.fastExpiration?.dateOnlyString ?? '---',
                  ),

                  /// --> Driver ANAM number
                  if(entity.internal?.anam != null)
                  CreateEntityFormRecordField(
                    label: 'ANAM',
                    value: entity.internal!.anam.cleaned ?? '---',
                  ),

                  /// --> Driver ANAM expiration date
                  if(entity.internal?.anamExpiration != null)
                  CreateEntityFormRecordField(
                    label: 'ANAM Expiration',
                    value: entity.internal?.anamExpiration?.dateOnlyString ?? '---',
                  ),

                  /// --> Driver TWIC number
                  if(entity.internal?.twic != null)
                  CreateEntityFormRecordField(
                    label: 'TWIC',
                    value: entity.internal!.twic.cleaned ?? '---',
                  ),

                  /// --> Driver TWIC expiration date
                  if(entity.internal?.twicExpiration != null)
                  CreateEntityFormRecordField(
                    label: 'TWIC Expiration',
                    value: entity.internal?.twicExpiration?.dateOnlyString ?? '---',
                  ),

                  /// --> Driver Email
                  if(entity.internal?.employee.approach?.email != null)
                  CreateEntityFormRecordField(
                    label: '*Email',
                    value: entity.internal!.employee.approach!.email.cleaned ?? '---',
                  ),

                  /// --> Driver enterprise phone number
                  if(entity.internal?.employee.approach?.enterprise != null)
                  CreateEntityFormRecordField(
                    label: 'Enterprise phone',
                    value: entity.internal!.employee.approach!.enterprise.cleaned ?? '---',
                  ),

                  /// --> Driver personal phone number
                  if(entity.internal?.employee.approach?.personal != null)
                  CreateEntityFormRecordField(
                    label: 'Personal number',
                    value: entity.internal!.employee.approach!.personal.cleaned ?? '---',
                  ),

                  /// --> Driver alternative contact.
                  if(entity.internal?.employee.approach?.alternative != null)
                  CreateEntityFormRecordField(
                    label: 'Alternative contact',
                    value: entity.internal!.employee.approach!.alternative.cleaned ?? '---',
                  ),

                  /// --> Driver address.
                  if(entity.internal?.employee.address?.country != null)
                  CreateEntityFormRecordField(
                    label: '*Country',
                    value: entity.internal!.employee.address!.country.cleaned ?? '---',
                  ),

                  /// --> State address.
                  if(entity.internal?.employee.address?.state != null)
                  CreateEntityFormRecordField(
                    label: 'State',
                    value: entity.internal!.employee.address!.state.cleaned ?? '---', 
                  ),

                  /// --> Street address.
                  if(entity.internal?.employee.address?.street != null)
                  CreateEntityFormRecordField(
                    label: 'Street',
                    value: entity.internal!.employee.address!.street.cleaned ?? '---',
                  ),

                  /// --> Alternative Street.
                  if(entity.internal?.employee.address?.altStreet != null)
                  CreateEntityFormRecordField(
                    label: 'Alt. Street',
                    value: entity.internal!.employee.address!.altStreet ?? '---',
                  ),

                  /// --> Driver City.
                  if(entity.internal?.employee.address?.city != null)
                  CreateEntityFormRecordField(
                    label: 'City',
                    value: entity.internal!.employee.address!.city.cleaned ?? '---',
                  ),

                  /// --> ZIP.
                  if(entity.internal?.employee.address?.zip != null)
                  CreateEntityFormRecordField(
                    label: 'ZIP',
                    value: entity.internal!.employee.address!.zip.cleaned ?? '---',
                  ),

                  /// --> Subdivision.
                  if(entity.internal?.employee.address?.subdivision != null)
                  CreateEntityFormRecordField(
                    label: 'Subdivision',
                    value: entity.internal!.employee.address!.subdivision ?? '---',
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

                /// --> Driver License
                CreateEntityFormRecordField(
                  label: '*License',
                  value: entity.license,
                ),
                
                /// --> Driver name
                CreateEntityFormRecordField(
                  label: '*Name',
                  value: entity.external?.identification.name ?? "---",
                ),

                /// --> Driver lastname
                CreateEntityFormRecordField(
                  label: '*Lastname',
                  value: entity.external?.identification.lastName ?? "---",
                ),

                /// --> Driver Birthday
                CreateEntityFormRecordField(
                  label: 'Birthday',
                  value: entity.external?.identification.birthDay?.dateOnlyString ?? "---",
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
                      label: '*License',
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
                            label: '*Assing a situation...',
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
                            label: '*Assing an status...',
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
