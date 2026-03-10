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
final class LocationsPageCreateWhisper extends ViewPageBase {

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
          factory: () => Location(),
          controller: creationController,
          authFactory: (BuildContext context) {
            SessionStorage sessionStorage = InjectorUtils.get();
            return sessionStorage.token;
          },
          recordDesigner: (Location entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField<Object>>[
                CreateEntityFormRecordField<String>(
                  label: 'Name',
                  value: entity.name,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Description',
                  value: entity.description,
                ),
                 CreateEntityFormRecordField<String>(
                  label: 'Status',
                  value: entity.status.name.cleaned,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Country',
                  value: entity.address.country,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'State',
                  value: entity.address.state,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'City',
                  value: entity.address.city,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Street',
                  value: entity.address.street,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Alt. Street',
                  value: entity.address.altStreet,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'ZIP',
                  value: entity.address.zip,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Subdivision/Colonia',
                  value: entity.address.subdivision,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Longitude',
                  value: entity.waypoint?.longitude.toString(),
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Latitude',
                  value: entity.waypoint?.latitude.toString(),
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Altitude',
                  value:entity.waypoint?.altitude.toString(),
                ),
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Location>? itemState, ScrollController scrollController) {
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
