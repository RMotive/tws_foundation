import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/list_viewer/list_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/selectable_list.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements the [EntityTableAdapterB] for [AccountsEntityTable] {widget}.
final class AccountsEntityTableAdatper extends FoundationEntityTableAdapterB<Account> {
  /// Creates a new [AccountsEntityTableAdatper] instance.
  AccountsEntityTableAdatper({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Account entity) {
    return EntityTableViewer(
      children: <Widget>[
        /// --> User
        PropertyViewer(
          label: 'Timestamp',
          value: entity.timestamp.dateOnly,
        ),
        /// --> User
        PropertyViewer(
          label: 'User',
          value: entity.user,
        ),
        /// --> Password
        PropertyViewer(
          label: 'Password',
          value: entity.password,
        ),
        /// --> Password
        PropertyViewer(
          label: 'Wildcard',
          value: entity.wildcard? 'Yes' : 'No',
        ),

        const SectionDivider(
          text: 'Contact details',
        ),

        /// --> Name
        PropertyViewer(
          label: 'Name',
          value: entity.contact.name,
        ),
         /// --> Lastname
        PropertyViewer(
          label: 'Lastname',
          value: entity.contact.lastName,
        ),
        /// --> Email
        PropertyViewer(
          label: 'Email',
          value: entity.contact.eMail,
        ),
        /// --> Phone
        PropertyViewer(
          label: 'Phone',
          value: entity.contact.phone,
        ),

        const SectionDivider(
          text: 'Security level details',
        ),
        /// Profiles list
        ListViewer<Profile>(
          title: 'Profiles', 
          tilesContent: entity.profiles,
          tileTitle: (Profile set) {
            return set.name;
          },
        ),

        /// Permits list
        ListViewer<Permit>(
          title: 'Permits', 
          tilesContent: entity.permits,
          tileTitle: (Permit set) {
            return '${set.solution.name} - ${set.name}';
          },
        )
      ],
    );
  }
   @override
  EntityTableAdapterEditor<Account>? composeEditor() {

    return EntityTableAdapterEditor<Account>(
      onUpdate: (BuildContext buildContext, Account entity) {
        final Router router = Injector.get();

        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(entity, router, context),
        );
      },

      formBuilder: (BuildContext buildContext, Account entity) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[
              /// --> Account details
              const SectionDivider(
                text: 'Account details',
              ),
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
                label: '*Username',
                maxLength: 50,
                controller: TextEditingController(
                  text: entity.user,
                ),
                onChanged: (String text) {
                  entity.user = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Password',
                controller: TextEditingController(
                  text: entity.password,
                ),
                onChanged: (String text) {
                  entity.password = text;
                },
              ),

              OptionsSelector<bool>(
                title: 'Wildcard',
                preSelected: <bool>[entity.wildcard],
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
                  entity.wildcard = selected.isNotEmpty ? selected.first : false;
                },
              ),

              /// --> Contact details
              const SectionDivider(
                text: 'Contact details',
              ),

              TextInput(
                width: double.infinity,
                label: '*Name',
                maxLength: 100,
                controller: TextEditingController(
                  text: entity.contact.name,
                ),
                onChanged: (String text) {
                  entity.contact.name = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Lastname',
                maxLength: 100,
                controller: TextEditingController(
                  text: entity.contact.lastName,
                ),
                onChanged: (String text) {
                  entity.contact.lastName = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Email',
                maxLength: 100,
                controller: TextEditingController(
                  text: entity.contact.eMail,
                ),
                onChanged: (String text) {
                  entity.contact.eMail = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Phone',
                maxLength: 14,
                controller: TextEditingController(
                  text: entity.contact.phone,
                ),
                onChanged: (String text) {
                  entity.contact.phone = text;
                },
              ),
              /// --> Security access level
              const SectionDivider(
                text: 'Security access details',
              ),

              SelectableList<Profile, ProfilesServiceI>(
                heigth: 350,
                title: 'Available Profiles',
                entityBuilder: () => Profile(),
                initialValues: entity.profiles,
                tileTitle: (Profile profile) => profile.name, 
                onSelect: (bool selected, Profile item) {  },
              ),

              SelectableList<Permit, PermitsServiceI>(
                heigth: 350,
                title: 'Available Permits',
                entityBuilder: () => Permit(),
                initialValues: entity.permits,
                tileTitle: (Permit permit) => '${permit.solution.name} - ${permit.name}', 
                onSelect: (bool selected, Permit item) {  },
              ),
            ],
          ),
        );
      },
    );
  }
  void _onUpdate(Account entity, Router router, BuildContext context) async {
    AccountServiceI accountsService = Injector.get();

    List<EntityInvalidation<Account>> invalidations = entity.evaluate();

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

    FoundationResponseResolver<UpdateOutput<Account>> resResolver = await accountsService.update(
      UpdateInput<Account>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      objectBuilder:
          () => UpdateOutput<Account>(
            () => Account(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<Account>> success) {
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

  Widget _buildUpdateDialog(Account entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Account update',
      router: router,
      context: context,
      acceptLabel: 'Update',
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'Username',
          value: entity.user.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Password',
          value: entity.password.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Wildcard',
          value: entity.wildcard? 'Yes' : 'No',
        ),
        TextLabel(
          title: 'Name',
          value: entity.contact.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Lastname',
          value: entity.contact.lastName.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Email',
          value: entity.contact.eMail.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Phone',
          value: entity.contact.phone.cleaned ?? '---',
        ),

        for(int i = 0; i < entity.profiles.length; i++)
        TextLabel(
          title: 'Profile #${i+1}',
          value: entity.profiles[i].name,
        ),

        for(int i = 0; i < entity.permits.length; i++)
        TextLabel(
          title: 'Permit #${i+1}',
          value: entity.permits[i].name,
        ),
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Account] {entity}, also handles basic available behavior.
final class AccountsEntityTable extends FoundationEntityTableB<AccountsEntityTableAdatper> {
  /// Creates a new [AccountsEntityTable] instance.
  const AccountsEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Account, AccountServiceI>(
      entityFactory: () => Account(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<Account>>[
        /// --> User
        EntityTableColumnOptions<Account>(
          title: 'User',
          factory: (Account entity, int index, BuildContext buildContext) => entity.user,
        ),
         /// --> Wildcard
        EntityTableColumnOptions<Account>(
          title: 'Wildcard',
          factory: (Account entity, int index, BuildContext buildContext) => entity.wildcard? 'Yes' : 'No',
        ),
        /// --> Name
        EntityTableColumnOptions<Account>(
          title: 'Name',
          factory: (Account entity, int index, BuildContext buildContext) => entity.contact.name,
        ),
        /// --> lastname
        EntityTableColumnOptions<Account>(
          title: 'Lastname',
          factory: (Account entity, int index, BuildContext buildContext) => entity.contact.lastName,
        ),
        /// --> Email
        EntityTableColumnOptions<Account>(
          title: 'Email',
          factory: (Account entity, int index, BuildContext buildContext) => entity.contact.eMail,
        ),
        /// --> Profiles
        EntityTableColumnOptions<Account>(
          title: 'Profiles',
          factory: (Account entity, int index, BuildContext buildContext) => entity.profiles.length.toString(),
        ),
        /// --> Permits
        EntityTableColumnOptions<Account>(
          title: 'Permits',
          factory: (Account entity, int index, BuildContext buildContext) => entity.permits.length.toString(),
        ),
      ],
    );
  }
}
