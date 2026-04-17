import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/selectable_list/selectable_list_async.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


part '_create_whisper_contacts.dart';


/// {whisper} class.
final class AccountsPageCreateWhisper extends ViewPageBase {

  /// Creates a new [AccountsPageCreateWhisper] instance.
  const AccountsPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();
    return Whisper(
      title: 'Create Account(s)',
      onPerform: () {
        creationController.create();
      },
      child: (GlobalKey<FormState> formState) {
        return CreateEntityForm<Account, AccountServiceI>(
          factory: () => Account(),
          controller: creationController,
          authFactory: (BuildContext context) {
            SessionStorage sessionStorage = InjectorUtils.get();
            return sessionStorage.token;
          },
          recordDesigner: (Account entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField<Object>>[
                /// --> User name.
                CreateEntityFormRecordField<String>(
                  label: '*Username',
                  value: entity.user,
                ),

                 /// --> Wildcard.
                CreateEntityFormRecordField<bool>(
                  label: '*Wildcard',
                  value: entity.wildcard,
                ),

                /// --> Profiles selected.
                for(int i = 0; i < entity.profiles.length; i++)
                CreateEntityFormRecordField<String>(
                  label: 'Profile #${i+1}',
                  value: entity.profiles[i].name,
                  ),
                
                /// --> Permits.
                CreateEntityFormRecordField<String>(
                  label: 'Permits',
                  value: entity.profiles.length.toString(),
                ),

                /// --> Contact name.
                CreateEntityFormRecordField<String>(
                  label: '*Name',
                  value: entity.contact.name,
                ),

                /// --> Contact name.
                CreateEntityFormRecordField<String>(
                  label: '*Lastname',
                  value: entity.contact.lastName,
                ),

                /// --> Contact email.
                CreateEntityFormRecordField<String>(
                  label: '*Email',
                  value: entity.contact.eMail,
                ),

                /// --> Contact lastname.
                CreateEntityFormRecordField<String>(
                  label: '*Phone',
                  value: entity.contact.phone,
                ),
                
                /// --> Contact email.
                CreateEntityFormRecordField<String>(
                  label: '*Email',
                  value: entity.contact.eMail,
                ),
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Account>? itemState, ScrollController scrollController) {
            final bool formDisabled = !(itemState == null);

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 12,
                children: <Widget>[
                 Row(
                    spacing: 10,
                    children: <Widget>[
                      /// --> User name
                      Expanded(
                        child: TextInput(
                          label: '*Name',
                          isEnabled: formDisabled,
                          maxLength: 50,
                          controller: TextEditingController(
                            text: itemState?.entity.user,
                          ),
                          onChanged: (String text) {
                            Account account = itemState!.entity;
                            account.user = text;
                            itemState.react();
                          },
                        ),
                      ),
            
                      /// --> Password
                      Expanded(
                        child: TextInput(
                          label: '*Password',
                          isEnabled: formDisabled,
                          controller: TextEditingController(
                            text: itemState?.entity.password,
                          ),
                          onChanged: (String text) {
                            Account account = itemState!.entity;
                            account.password = text;
                            itemState.react();
                          },
                        ),
                      ),
                    ],
                  ),
            
                  EntityFinderSelector<Contact, ContactsServiceI>(
                    entityBuilder: () => Contact(),
                    label: 'Select the contact information...',
                    initialValue: itemState?.entity.contact,
                    textBuilder: (Contact contact) {
                      return '${contact.name} ${contact.lastName}';
                    },
                    onSelected: (Contact? solution) {
                      itemState?.entity.contact = solution ?? Contact();
                      itemState?.react();
                    },
                  ),
            
                  FoldPanelWidget(
                    title: 'Add Contact',
                    child: _CreateWhisperContactsSection(
                      itemState: itemState,
                      isEnabled: formDisabled,
                    ),
                  ),
                  OptionsSelector<bool>(
                    title: 'Wildcard',
                    preSelected: <bool>[itemState!.entity.wildcard],
                    options: <OptionsSelectorOption<bool>>[
                      OptionsSelectorOption<bool>(
                        title: 'Yes',
                        value: true,
                      ),
                      OptionsSelectorOption<bool>(
                        title: 'No',
                        value: false,
                      ),
                    ],
                    onSelect:(List<bool> selected) {
                      Account account = itemState.entity;
                      account.wildcard = selected.isNotEmpty ? selected.first : false;
                      itemState.react();
                    },
                  ),
            
            
            
                  SelectableListAsync<Profile, ProfilesServiceI>(
                    height: 500,
                    title: 'Available Profiles',
                    entityBuilder: () => Profile(),
                    initialValues: itemState.entity.profiles,
                    tileTitle:(Profile profile) => profile.name,
                    onSelect:(bool selected, Profile item) {
                      itemState.react();
                    },
                  ),
            
                  SelectableListAsync<Permit, PermitsServiceI>(
                    height: 500,
                    title: 'Available Permits',
                    entityBuilder: () => Permit(),
                    initialValues: itemState.entity.permits,
                    tileTitle:(Permit permit) => '${permit.solution.name} - ${permit.name}',
                    onSelect:(bool selected, Permit item) {
                      itemState.react();
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
