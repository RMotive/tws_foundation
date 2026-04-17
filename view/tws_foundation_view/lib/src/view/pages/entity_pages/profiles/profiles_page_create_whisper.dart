import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/selectable_list/selectable_list_async.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {whisper} class.
final class ProfilesPageCreateWhisper extends ViewPageBase {

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
          factory: () => Profile(),
          controller: creationController,
          authFactory: (BuildContext context) {
            SessionStorage sessionStorage = InjectorUtils.get();
            return sessionStorage.token;
          },
          recordDesigner: (Profile entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField<Object>>[

                /// --> Profile name.
                CreateEntityFormRecordField<String>(
                  label: '*Name',
                  value: entity.name,
                ),

                /// --> Profile description.
                CreateEntityFormRecordField<String>(
                  label: 'Description',
                  value: entity.description.cleaned,
                ),
                
                /// --> Profile permits.
                for(int i = 0; i < entity.permits.length; i++)
                CreateEntityFormRecordField<String>(
                  label: 'Permit #${i+1}',
                  value: entity.permits[i].name,
                ),
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Profile>? itemState, ScrollController scrollController) {
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
                  SelectableListAsync<Permit, PermitsServiceI>(
                    height: 500,
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
            );
          },
        );
      },
    );
  }
}
