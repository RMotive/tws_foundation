import 'dart:convert';

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/photo_taker/photo_taker.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {whisper} class.
final class SectionsPageCreateWhisper extends PageB {

  /// Creates a new [SectionsPageCreateWhisper] instance.
  const SectionsPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();
    return Whisper(
      title: 'Create Section(s)',
      onPerform: () {
        creationController.create();
      },
      child: (GlobalKey<FormState> formState) {
        return CreateEntityForm<Section, SectionsServiceI>(
          entityFactory: () => Section(),
          controller: creationController,
          buildEntityTag: (Section entity) {
            return 'Section with name: ${entity.name}';
          },
          recordDesigner: (Section entity, bool selected, bool valid) {
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
                  label: 'Yard',
                  value: entity.yard.name.cleaned ?? '---',
                ),
                CreateEntityFormRecordField(
                  label: 'Capacity',
                  value: entity.capacity.toString(),
                ),
                CreateEntityFormRecordField(
                  label: 'Resource',
                  value: entity.resource != null? 'Yes' : 'No',
                ),
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Section>? itemState) {
            final bool formDisabled = !(itemState == null);

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 12,
                children: <Widget>[
                  Row(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// --> Section Name
                      Expanded(
                        child: TextInput(
                          label: 'Name',
                          isEnabled: formDisabled,
                          maxLength: 32,
                          controller: TextEditingController(
                            text: itemState?.entity.name,
                          ),
                          onChanged: (String text) {
                            Section section = itemState!.entity;
                            section.name = text;
                            itemState.react();
                          },
                        ),
                      ),

                      /// --> Section Description
                      Expanded(
                        child: TextInput(
                          label: 'Description',
                          isEnabled: formDisabled,
                          maxLength: 32,
                          controller: TextEditingController(
                            text: itemState?.entity.description,
                          ),
                          onChanged: (String text) {
                            Section section = itemState!.entity;
                            section.description = text;
                            itemState.react();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: <Widget>[
                       Expanded(
                        child: EntityFinderSelector<Status, StatusesServiceI>(
                          entityBuilder: () => Status(),
                          label: 'Select Status',
                          initialValue: itemState?.entity.status,
                          textBuilder: (Status status) {
                            return status.name;
                          },
                          onSelected: (Status? status) {
                            Section section = itemState!.entity;
                            section.status = status ?? Status();
                            itemState.react();
                          },
                        ),
                      ),

                      Expanded(
                        child: EntityFinderSelector<Location, LocationsServiceI>(
                          entityBuilder:() => Location(),
                          label: 'Select Location yard',
                          initialValue: itemState?.entity.yard,
                          textBuilder: (Location location) {
                            return location.name;
                          },
                          onSelected: (Location? location) {
                            Section section = itemState!.entity;
                            section.yard = location ?? Location();
                            itemState.react();  
                          },
                        ),
                      ),
                    ],
                  ),

                  SectionWidget(
                    title: 'Resource Image',
                    outterPadding: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PhotoTaker(
                        preLoadBase64:
                            itemState!.entity.resource != null ? base64Encode(itemState.entity.resource!.file) : null,
                        onPhotoTaken: (XFile photo) async {
                          Section entity = itemState.entity;
                          Resource resource = Resource();
                          resource.file = await photo.readAsBytes();
                          resource.name = 'Section_Resource${entity.name}_at_${entity.timestamp}';
                          resource.extension = photo.path.split('.').last;
                          entity.resource = resource;
                          itemState.react();  
                        },
                      ),
                    ),
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
