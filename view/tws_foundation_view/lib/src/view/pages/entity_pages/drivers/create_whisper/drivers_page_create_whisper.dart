import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_datepicker_field.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_create_whisper_drivers_section.dart';
part '_create_whisper_drivers_externals_section.dart';

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
      child: CreateEntityForm<DriverCommon>(
        entityFactory: () => DriverCommon(),
        recordDesigner: (DriverCommon entity, bool selected, bool valid) {
          return CreateEntityFormRecord(
            selected: selected,
            fields: <CreateEntityFormRecordField>[
              /// --> Driver License
              CreateEntityFormRecordField(
                label: 'License',
                value: entity.license,
              ),
              
              /// --> Driver ownership type
              CreateEntityFormRecordField(
                label: 'Ownership',
                value: entity.internal != null ? 'Owner' : 'External',
              ),
              
              /// --> Driver name
              CreateEntityFormRecordField(
                label: 'Name',
                value:
                    entity.internal != null
                        ? entity.internal?.employee.identification.name
                        : entity.external?.identification.name ?? "---",
              ),

              /// --> Driver lastname
              CreateEntityFormRecordField(
                label: 'Lastname',
                value:
                    entity.internal != null
                        ? entity.internal?.employee.identification.lastName
                        : entity.external?.identification.lastName ?? "---",
              ),

              /// --> Driver Type
              CreateEntityFormRecordField(
                label: 'Type',
                value: entity.internal?.driverType ?? "---",
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
        },
        formDesigner: (CreateEntityFormRecordReactor<DriverCommon>? itemState) {
          final bool formDisabled = !(itemState == null);
          if(formDisabled && itemState.entity.internal == null && itemState.entity.external == null) {
            itemState.entity.internal = Driver();
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 12,
              children: <Widget>[
                /// --> Ownership Type
                SectionWidget(
                  title: 'Ownership',
                  outterPadding: EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OptionsSelector<bool>(
                      preSelected: <bool>[
                        itemState?.entity.external != null ? false : true,
                      ],
                      options: <OptionsSelectorOption<bool>>[
                        OptionsSelectorOption<bool>(
                          title: 'Owner',
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
                ),

                /// --> Employee Full Name
                Row(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /// --> Driver License
                    Expanded(
                      child: TextInput(
                        label: 'License',
                        isEnabled: formDisabled,
                        controller: TextEditingController(
                          text: itemState?.entity.license,
                        ),
                        onChanged: (String text) {
                          DriverCommon common = itemState!.entity;
                          common.license = text;
                          itemState.react();
                        },
                      ),
                    ),                   
                  ],
                ),
                // --> Driver edge Section
                ReactiveWidget<_DriverSectionState>(
                  reactor: _driverSectionState,
                  builder: (BuildContext ctx, _DriverSectionState reactor) {
                    _driverSectionStateReact = reactor.react;
                    return itemState?.entity.external != null? 
                      _CreateWhisperDriversExternalsSection(
                        itemState: itemState,
                        isEnabled: formDisabled,
                      ) : _CreateWhisperDriversSection(
                        itemState: itemState,
                        isEnabled: formDisabled,
                      );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
