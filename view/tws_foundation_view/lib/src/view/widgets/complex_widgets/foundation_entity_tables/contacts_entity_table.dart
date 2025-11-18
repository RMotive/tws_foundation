import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
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
        PropertyViewer(
          label: 'Name',
          value: entity.name,
        ),

        /// --> Lastname
        PropertyViewer(
          label: 'Lastname',
          value: entity.lastName,
        ),

        /// --> Email
        PropertyViewer(
          label: 'Email',
          value: entity.eMail,
        ),

        /// --> Phone number
        PropertyViewer(
          label: 'Phone number',
          value: entity.phone,
        ),
      ],
    );
  }

 @override
  EntityTableAdapterEditor<Contact>? composeEditor() {

    return EntityTableAdapterEditor<Contact>(
      onUpdate: (BuildContext buildContext, Contact entity) {
        final Router router = Injector.get();

        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(entity, router, context),
        );
      },

      formBuilder:(BuildContext buildContext, Contact entity) {
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
                  text: entity.timestamp.fullDate,
                ),
              ),
              TextInput(
                width: double.infinity,
                label: '*Name',
                maxLength: 100,
                controller: TextEditingController(
                  text: entity.name,
                ),
                onChanged: (String text) {
                  entity.name = text;
                },
              ),
              TextInput(
                width: double.infinity,
                label: '*Lastname',
                maxLength: 100,
                controller: TextEditingController(
                  text: entity.lastName,
                ),
                onChanged: (String text) {
                  entity.lastName = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Email',
                maxLength: 100,
                controller: TextEditingController(
                  text: entity.eMail,
                ),
                onChanged: (String text) {
                  entity.eMail = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Phone',
                maxLength: 14,
                controller: TextEditingController(
                  text: entity.phone,
                ),
                onChanged: (String text) {
                  entity.phone = text;
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _onUpdate(Contact entity, Router router, BuildContext context) async {
    ContactsServiceI contactsService = Injector.get();

    List<EntityInvalidation<Contact>> invalidations = entity.evaluate();

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
      objectBuilder:
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
        router.pop();
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
              theming: Theming.get<FoundationThemeB>(context).error,
              onAccept: () {
                router.pop();
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
final class ContactsEntityTable extends FoundationEntityTableB<ContactsEntityTableAdapter> {
  /// Creates a new [ContactsEntityTable] instance.
  const ContactsEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Contact, ContactsServiceI>(
      entityFactory: () => Contact(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<Contact>>[
        /// --> Name
        EntityTableColumnOptions<Contact>(
          title: 'Name',
          factory: (Contact entity, int index, BuildContext buildContext) => entity.name,
        ),

        /// --> Lastname
        EntityTableColumnOptions<Contact>(
          title: 'Lastname',
          factory: (Contact entity, int index, BuildContext buildContext) => entity.lastName,
        ),

        /// --> Email
        EntityTableColumnOptions<Contact>(
          title: 'Email',
          factory: (Contact entity, int index, BuildContext buildContext) => entity.eMail,
        ),

        /// --> Phone number
        EntityTableColumnOptions<Contact>(
          title: 'Phone number',
          factory: (Contact entity, int index, BuildContext buildContext) => entity.phone,
        ),
      ],
    );
  }
}
