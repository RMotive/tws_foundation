import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter, TextInputFormatter;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/coordenates_formatter.dart';
import 'package:tws_foundation_view/src/data/const/static_collections.dart';
import 'package:tws_foundation_view/src/view/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


part '_create_whisper_address.dart';
part '_create_whisper_waypoint.dart';

/// {whisper} class.
final class LocationsPageCreateWhisper extends PageB {

  /// Creates a new [LocationsPageCreateWhisper] instance.
  const LocationsPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();
    return Whisper(
      title: 'Create Location(s)',
      onPerform: () {
        creationController.create();
      },
      child: (GlobalKey<FormState> formState) {
        return CreateEntityForm<Location, LocationsServiceI>(
          entityFactory: () => Location(),
          controller: creationController,
          buildEntityTag: (Location entity) {
            return 'Location with name: ${entity.name}';
          },
          recordDesigner: (Location entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField>[
                CreateEntityFormRecordField(
                  label: 'Name',
                  value: entity.name,
                ),
                CreateEntityFormRecordField(
                  label: 'Description',
                  value: entity.description ?? '---',
                ),
                 CreateEntityFormRecordField(
                  label: 'Status',
                  value: entity.status.name.cleaned ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'Country',
                  value: entity.address.country,
                ),
                CreateEntityFormRecordField(
                  label: 'State',
                  value: entity.address.state ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'City',
                  value: entity.address.city ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'Street',
                  value: entity.address.street ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'Alt. Street',
                  value: entity.address.altStreet ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'ZIP',
                  value: entity.address.zip ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'Subdivision/Colonia',
                  value: entity.address.subdivision ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'Longitude',
                  value: entity.waypoint?.longitude.toString() ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'Latitude',
                  value: entity.waypoint?.latitude.toString() ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'Altitude',
                  value:entity.waypoint?.altitude != null? entity.waypoint?.altitude.toString() ?? '---' : "---",
                ),
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Location>? itemState) {
            final bool formDisabled = !(itemState == null);

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 12,
                children: <Widget>[
                  /// --> Location Name
                  Row(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// --> Location Name
                      Expanded(
                        child: TextInput(
                          label: 'Name',
                          isEnabled: formDisabled,
                          maxLength: 32,
                          controller: TextEditingController(
                            text: itemState?.entity.name,
                          ),
                          onChanged: (String text) {
                            Location location = itemState!.entity;
                            location.name = text;
                            itemState.react();
                          },
                        ),
                      ),

                      /// --> Location Description
                      Expanded(
                        child: TextInput(
                          label: 'Description',
                          isEnabled: formDisabled,
                          maxLength: 32,
                          controller: TextEditingController(
                            text: itemState?.entity.description,
                          ),
                          onChanged: (String text) {
                            Location location = itemState!.entity;
                            location.description = text;
                            itemState.react();
                          },
                        ),
                      ),
                    ],
                  ),
                  EntityFinderSelector<Status, StatusesServiceI>(
                    entityBuilder:() => Status(),
                    label: 'Select Status',
                    initialValue: itemState?.entity.status,
                    textBuilder: (Status status) {
                      return status.name;
                    },
                    onSelected: (Status? status) {
                      Location location = itemState!.entity;
                      location.status = status ?? Status();
                      itemState.react();  
                    },
                  ),

                  _CreateWhisperAddressesSection(
                    itemState: itemState,
                    isEnabled: true,
                  ),

                  _CreateWhisperWaypointsSection(
                    itemState: itemState,
                    isEnabled: true,
                  ),
                  
                ],
              ),
            );
          },
        );
      },
    );
  }
}
