import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/selectable_list.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {whisper} class.
final class ProfilesPageCreateWhisper extends PageB {

  /// Creates a new [ProfilesPageCreateWhisper] instance.
  const ProfilesPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();
    return Whisper(
      title: 'Create Profile(s)',
      onPerform: () {
        creationController.create();
      },
      child: (GlobalKey<FormState> formState) {
        return CreateEntityForm<Profile, ProfilesServiceI>(
          entityFactory: () => Profile(),
          controller: creationController,
          buildEntityTag: (Profile entity) {
            return 'Profile with name: ${entity.name}';
          },
          recordDesigner: (Profile entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField>[

                /// --> Profile name.
                CreateEntityFormRecordField(
                  label: '*Name',
                  value: entity.name,
                ),

                /// --> Profile description.
                CreateEntityFormRecordField(
                  label: 'Description',
                  value: entity.description.cleaned ?? '---',
                ),
                
                /// --> Profile permits.
                for(int i = 0; i < entity.permits.length; i++)
                CreateEntityFormRecordField(
                  label: 'Permit #${i+1}',
                  value: entity.permits[i].name,
                ),
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Profile>? itemState) {
            final bool formDisabled = !(itemState == null);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 12,
                  children: <Widget>[
                    Row(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// --> Profile Name
                        Expanded(
                          child: TextInput(
                            label: '*Name',
                            isEnabled: formDisabled,
                            maxLength: 100,
                            controller: TextEditingController(
                              text: itemState?.entity.name,
                            ),
                            onChanged: (String text) {
                              Profile profile = itemState!.entity;
                              profile.name = text;
                              itemState.react();
                            },
                          ),
                        ),
                         /// --> Description
                        Expanded(
                          child: TextInput(
                            label: 'Description',
                            isEnabled: formDisabled,
                            maxLength: 200,
                            controller: TextEditingController(
                              text: itemState?.entity.description,
                            ),
                            onChanged: (String text) {
                              Profile profile = itemState!.entity;
                              profile.description = text.cleaned;
                              itemState.react();
                            },
                          ),
                        ),
                      ],
                    ),
                    SelectableList<Permit, PermitsServiceI>(
                      heigth: 500,
                      title: 'Available Permits',
                      entityBuilder: () => Permit(),
                      initialValues: itemState?.entity.permits,
                      tileTitle:(Permit permit) => '${permit.solution.name} - ${permit.name}',
                      onSelect:(bool selected, Permit item) {
                        itemState?.react();
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
