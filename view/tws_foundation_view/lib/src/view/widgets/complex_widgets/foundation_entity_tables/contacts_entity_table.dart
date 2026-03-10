import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements the [EntityTableAdapterB] for [ContactsEntityTable] {widget}.
final class ContactsEntityTableAdapter extends FoundationEntityTableAdapterB<Contact> {
  /// Creates a new [ContactsEntityTableAdapter] instance.
  ContactsEntityTableAdapter({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Contact entity) {
    return EntityTableViewer(
      children: <Widget>[
        /// --> Name
        PropertyViewer<String>(
          label: 'Name',
          value: entity.name,
        ),

        /// --> Lastname
        PropertyViewer<String>(
          label: 'Lastname',
          value: entity.lastName,
        ),

        /// --> Email
        PropertyViewer<String>(
          label: 'Email',
          value: entity.eMail,
        ),

        /// --> Phone number
        PropertyViewer<String>(
          label: 'Phone number',
          value: entity.phone,
        ),
      ],
    );
  }

 @override
  EntityTableAdapterEditor<Contact>? composeEditor() {

    return EntityTableAdapterEditor<Contact>(
      onUpdate: (EntityTableAdapterEditorData<Contact> data) {
        final Router router = InjectorUtils.get();
 
        showDialog(
          context: data.context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(data.entity, router, context),
        );
      },

      formBuilder:(EntityTableAdapterEditorData<Contact> data) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[
              TextInput(
                width: double.infinity,
                label: 'Timestamp',
                isEnabled: false,
                controller: TextEditingController(
                  text: data.entity.timestamp.fullDate,
                ),
              ),
              TextInput(
                width: double.infinity,
                label: '*Name',
                maxLength: 100,
                controller: TextEditingController(
                  text: data.entity.name,
                ),
                onChanged: (String text) {
                  data.entity.name = text;
                },
              ),
              TextInput(
                width: double.infinity,
                label: '*Lastname',
                maxLength: 100,
                controller: TextEditingController(
                  text: data.entity.lastName,
                ),
                onChanged: (String text) {
                  data.entity.lastName = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Email',
                maxLength: 100,
                controller: TextEditingController(
                  text: data.entity.eMail,
                ),
                onChanged: (String text) {
                  data.entity.eMail = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Phone',
                maxLength: 14,
                controller: TextEditingController(
                  text: data.entity.phone,
                ),
                onChanged: (String text) {
                  data.entity.phone = text;
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _onUpdate(Contact entity, Router router, BuildContext context) async {
    ContactsServiceI contactsService = InjectorUtils.get();

    List<EntityErrors<Contact>> invalidations = entity.evaluate(<EntityErrors<Contact>>[]);

    if(invalidations.isNotEmpty){
      await showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InvalidatingDialog(
            title: 'Invalid Values',
            invalidations: invalidations,
            router: router,
            context: context,
          );
        },
      );
      return;
    }

    String authToken = await composeAuth();

    FoundationResponseResolver<UpdateOutput<Contact>> resResolver = await contactsService.update(
      UpdateInput<Contact>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      factory:
          () => UpdateOutput<Contact>(
            () => Contact(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<Contact>> success) {
        refresh();
      },
      onFailure: (FailureFrame failure, int status) {
        errMessage = failure.content.advise;
      },
      onException: (TracedException exception) {
        errMessage = FoundationMessages.unknownServerException;
      },
      onConnectionFailure: () {
        errMessage = FoundationMessages.connectionError;
      },
      onFinally: () {
        Navigator.of(context).pop();
        if (errMessage == null) return;

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              showCancelButton: false,
              title: 'Error Updating contact',
              content: Text(
                errMessage as String,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              theming: ThemingUtils.get<FoundationThemeB>(context).controlError,
              onAccept: () {
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }

  Widget _buildUpdateDialog(Contact entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Contact update',
      router: router,
      context: context,
      acceptLabel: 'Update',
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'Name',
          value: entity.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Lastname',
          value: entity.lastName.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Email',
          value: entity.eMail.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Phone',
          value: entity.phone.cleaned ?? '---',
        ),
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Contact] {entity}, also handles basic available behavior.
final class ContactsEntityTable extends FoundationEntityTableB<Contact, ContactsEntityTableAdapter> {
  /// Creates a new [ContactsEntityTable] instance.
  const ContactsEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Contact, FoundationResponseResolver<ViewOutput<Contact>>, ContactsServiceI>(
      factory: () => Contact(),
      adapter: adapter,
      columns: <EntityTableColumnData<Contact>>[
        /// --> Name
        EntityTableColumnData<Contact>(
          title: 'Name',
          factory: (Contact entity, int index, BuildContext buildContext) => entity.name,
        ),

        /// --> Lastname
        EntityTableColumnData<Contact>(
          title: 'Lastname',
          factory: (Contact entity, int index, BuildContext buildContext) => entity.lastName,
        ),

        /// --> Email
        EntityTableColumnData<Contact>(
          title: 'Email',
          factory: (Contact entity, int index, BuildContext buildContext) => entity.eMail,
        ),

        /// --> Phone number
        EntityTableColumnData<Contact>(
          title: 'Phone number',
          factory: (Contact entity, int index, BuildContext buildContext) => entity.phone,
        ),
      ],
    );
  }
}
