import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog, Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/list_viewer/list_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/selectable_list/selectable_list_async.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements the [EntityTableAdapterB] for [ProfilesEntityTable] {widget}.
final class ProfilesEntityTableAdapter extends FoundationEntityTableAdapterB<Profile> {
  /// Creates a new [ProfilesEntityTableAdapter] instance.
  ProfilesEntityTableAdapter({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Profile entity) {
    return EntityTableViewer(
      children: <Widget>[

        /// --> Timestamp
        PropertyViewer<String>(
          label: 'Timestamp',
          value: entity.timestamp.fullDate,
        ),

        /// --> Name
        PropertyViewer<String>(
          label: 'Name',
          value: entity.name,
        ),

        /// --> Description
        PropertyViewer<String>(
          label: 'Description',
          value: entity.description ?? '---',
        ),

        const SectionDivider(text: 'Associated Permits'),

        ListViewer<Permit>(
          title: 'Permits',
          tilesContent: entity.permits,
          tileTitle:(Permit permit) => '${permit.solution} - ${permit.name}',
        ),
      ],
    );
  }

 @override
  EntityTableAdapterEditor<Profile>? composeEditor() {

    return EntityTableAdapterEditor<Profile>(
      onUpdate: (EntityTableAdapterEditorData<Profile> data) {
        final Router router = InjectorUtils.get();

        showDialog(
          context: data.context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(data.entity, router, context),
        );
      },

      formBuilder:(EntityTableAdapterEditorData<Profile> data) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[
              const SectionDivider(text: 'Permit details'),
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
                label: 'Description',
                maxLength: 200,
                controller: TextEditingController(
                  text: data.entity.description,
                ),
                onChanged: (String text) {
                  data.entity.description = text.cleaned;
                },
              ),
              SelectableListAsync<Permit, PermitsServiceI>(
                title: 'Available Permits',
                entityBuilder: () => Permit(),
                initialValues: data.entity.permits,
                tileTitle:(Permit permit) => '${permit.solution.name} - ${permit.name}',
                onSelect:(bool selected, Permit item) {
                  if(selected){
                    if(data.entity.permits.contains(item)) return;
                    data.entity.permits.add(item);
                    return;
                  }
                  data.entity.permits.remove(item);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _onUpdate(Profile entity, Router router, BuildContext context) async {
    ProfilesServiceI profilesService = InjectorUtils.get();

    List<EntityErrors<Profile>> invalidations = entity.evaluate(<EntityErrors<Profile>>[]);

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

    FoundationResponseResolver<UpdateOutput<Profile>> resResolver = await profilesService.update(
      UpdateInput<Profile>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      factory:
          () => UpdateOutput<Profile>(
            () => Profile(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<Profile>> success) {
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

  Widget _buildUpdateDialog(Profile entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Permit update',
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
          title: 'Description',
          value: entity.description.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Assigned permits',
          value: entity.permits.length.toString(),
        ),
        for(int i = 0; i > entity.permits.length; i++)
        TextLabel(
          title: 'Permit #$i',
            value: '${entity.permits[i].solution} - ${entity.permits[i].name}',
          ),
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Profile] {entity}, also handles basic available behavior.
final class ProfilesEntityTable extends FoundationEntityTableB<Profile, ProfilesEntityTableAdapter> {
  /// Creates a new [ProfilesEntityTable] instance.
  const ProfilesEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Profile, ResponseResolverBase<ViewOutput<Profile>>, ProfilesServiceI>(
      factory: () => Profile(),
      adapter: adapter,
      columns: <EntityTableColumnData<Profile>>[
        /// --> Name
        EntityTableColumnData<Profile>(
          title: 'Name',
          factory: (Profile entity, int index, BuildContext buildContext) => entity.name,
        ),

        /// --> Description
        EntityTableColumnData<Profile>(
          title: 'Description',
          factory: (Profile entity, int index, BuildContext buildContext) => entity.description ?? '---',
        ),

        /// --> Associated permits
        EntityTableColumnData<Profile>(
          title: 'associated permits',
          factory: (Profile entity, int index, BuildContext buildContext) => entity.permits.length.toString(),
        ),
      ],
    );
  }
}
