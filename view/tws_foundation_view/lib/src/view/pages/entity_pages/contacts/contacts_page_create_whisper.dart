import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {whisper} class.
final class ContactsPageCreateWhisper extends ViewPageBase {

  /// Creates a new [ContactsPageCreateWhisper] instance.
  const ContactsPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();
    return Whisper(
      title: 'Create Contact(s)',
      onPerform: () {
        creationController.create();
      },
      child: (GlobalKey<FormState> formState) {
        return CreateEntityForm<Contact, ContactsServiceI>(
          factory: () => Contact(),
          controller: creationController,
          authFactory: (BuildContext context) {
            SessionStorage sessionStorage = InjectorUtils.get();
            return sessionStorage.token;
          },
          recordDesigner: (Contact entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField<Object>>[
                /// --> Contact name.
                CreateEntityFormRecordField<String>(
                  label: '*Name',
                  value: entity.name,
                ),

                /// --> Contact lastname.
                CreateEntityFormRecordField<String>(
                  label: '*Lastname',
                  value: entity.lastName,
                ),
                
                /// --> Contact email.
                CreateEntityFormRecordField<String>(
                  label: '*Email',
                  value: entity.eMail,
                ),
                /// --> Contact phone number.
                CreateEntityFormRecordField<String>(
                  label: '*phone',
                  value: entity.phone,
                ),
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Contact>? itemState, ScrollController scrollController) {
            final bool formDisabled = !(itemState == null);

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 12,
                children: <Widget>[
                  /// --> Contact Full Name
                  Row(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// --> Contact Name
                      Expanded(
                        child: TextInput(
                          label: '*Name',
                          isEnabled: formDisabled,
                          maxLength: 100,
                          controller: TextEditingController(
                            text: itemState?.entity.name,
                          ),
                          onChanged: (String text) {
                            Contact contact = itemState!.entity;
                            contact.name = text;
                            itemState.react();
                          },
                        ),
                      ),
                      /// --> Contact Name
                      Expanded(
                        child: TextInput(
                          label: '*Lastname',
                          isEnabled: formDisabled,
                          maxLength: 100,
                          controller: TextEditingController(
                            text: itemState?.entity.lastName,
                          ),
                          onChanged: (String text) {
                            Contact contact = itemState!.entity;
                            contact.lastName = text;
                            itemState.react();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: <Widget>[
                      /// --> Contact Email
                      Expanded(
                        child: TextInput(
                          label: '*Email',
                          isEnabled: formDisabled,
                          maxLength: 100,
                          controller: TextEditingController(
                            text: itemState?.entity.eMail,
                          ),
                          onChanged: (String text) {
                            Contact contact = itemState!.entity;
                            contact.eMail = text;
                            itemState.react();
                          },
                        ),
                      ),
            
                      /// --> Phone number
                      Expanded(
                        child: TextInput(
                          label: '*Phone number',
                          isEnabled: formDisabled,
                          maxLength: 14,
                          controller: TextEditingController(
                            text: itemState?.entity.phone,
                          ),
                          onChanged: (String text) {
                            Contact contact = itemState!.entity;
                            contact.phone = text;
                            itemState.react();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
