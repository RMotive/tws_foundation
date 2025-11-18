import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog, Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements the [EntityTableAdapterB] for [PermitsEntityTable] {widget}.
final class PermitsEntityTableAdapter extends FoundationEntityTableAdapterB<Permit> {
  /// Creates a new [PermitsEntityTableAdapter] instance.
  PermitsEntityTableAdapter({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Permit entity) {
    return EntityTableViewer(
      children: <Widget>[

        /// --> Timestamp
        PropertyViewer(
          label: 'Timestamp',
          value: entity.timestamp.fullDate,
        ),

        /// --> Reference
        PropertyViewer(
          label: 'Reference code',
          value: entity.reference,
        ),

        /// --> Name
        PropertyViewer(
          label: 'Name',
          value: entity.name,
        ),

        /// --> Description
        PropertyViewer(
          label: 'Description',
          value: entity.description ?? '---',
        ),

        /// --> Email
        PropertyViewer(
          label: 'Enabled',
          value: entity.enabled? 'Yes' : 'No',
        ),

        /// --> Solution 
        PropertyViewer(
          label: 'Solution',
          value: entity.solution.name,
        ),

        SectionDivider(text: 'Feature details'),

        /// --> Feature name 
        PropertyViewer(
          label: 'Feature',
          value: entity.feature.name,
        ),

        /// --> Feature enabled status
        PropertyViewer(
          label: 'Feature enabled',
          value: entity.feature.enabled? 'Yes' : 'No',
        ),

        SectionDivider(text: 'Action details'),

        /// --> Action name 
        PropertyViewer(
          label: 'Action',
          value: entity.action.name,
        ),

        /// --> Action enabled status
        PropertyViewer(
          label: 'Action enabled',
          value: entity.action.enabled? 'Yes' : 'No',
        ),
      ],
    );
  }

 @override
  EntityTableAdapterEditor<Permit>? composeEditor() {

    return EntityTableAdapterEditor<Permit>(
      onUpdate: (BuildContext buildContext, Permit entity) {
        final Router router = Injector.get();

        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(entity, router, context),
        );
      },

      formBuilder:(BuildContext buildContext, Permit entity) {
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
                  text: entity.timestamp.fullDate,
                ),
              ),
              OptionsSelector<bool>(
                title: 'Enabled',
                preSelected: <bool>[entity.enabled],
                options:  <OptionsSelectorOption<bool>>[
                  OptionsSelectorOption<bool>(
                    title: 'Yes',
                    value: true,
                  ),
                  OptionsSelectorOption<bool>(
                    title: 'No',
                    value: false,
                  ),
                ],
                onSelect: (List<bool> selected) {
                  entity.enabled = selected.firstOrNull ?? false;
                },
              ),
              TextInput(
                width: double.infinity,
                label: '*Reference code',
                maxLength: 8,
                isFixedLength: true,
                controller: TextEditingController(
                  text: entity.reference,
                ),
                onChanged: (String text) {
                  entity.reference = text;
                },
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
                label: 'Description',
                maxLength: 200,
                controller: TextEditingController(
                  text: entity.description,
                ),
                onChanged: (String text) {
                  entity.description = text.cleaned;
                },
              ),
              EntityFinderSelector<Solution, SolutionsServiceI>(
                entityBuilder: () => Solution(),
                label: '*Select a Solution...',
                initialValue: entity.solution,
                textBuilder: (Solution solution) {
                  return solution.name;
                },
                onSelected: (Solution? solution) {
                  entity.solution = solution ?? Solution();
                },
              ),
              EntityFinderSelector<Feature, FeaturesServiceI>(
                entityBuilder: () => Feature(),
                label: '*Select a Feature...',
                initialValue: entity.feature,
                textBuilder: (Feature feature) {
                  return feature.name;
                },
                onSelected: (Feature? feature) {
                  entity.feature = feature ?? Feature();
                },
              ),
              EntityFinderSelector<Action, ActionsServiceI>(
                entityBuilder: () => Action(),
                label: '*Select an Action...',
                initialValue: entity.action,
                textBuilder: (Action action) {
                  return action.name;
                },
                onSelected: (Action? action) {
                  entity.action = action ?? Action();
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _onUpdate(Permit entity, Router router, BuildContext context) async {
    PermitsServiceI permitsService = Injector.get();

    List<EntityInvalidation<Permit>> invalidations = entity.evaluate();

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

    FoundationResponseResolver<UpdateOutput<Permit>> resResolver = await permitsService.update(
      UpdateInput<Permit>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      objectBuilder:
          () => UpdateOutput<Permit>(
            () => Permit(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<Permit>> success) {
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

  Widget _buildUpdateDialog(Permit entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Permit update',
      router: router,
      context: context,
      acceptLabel: 'Update',
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'Reference code',
          value: entity.reference,
        ),
        TextLabel(
          title: 'Name',
          value: entity.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Description',
          value: entity.description.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Enabled',
          value: entity.enabled? 'Yes' : 'No',
        ),
        TextLabel(
          title: 'Solution',
          value: entity.solution.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Feature',
          value: entity.feature.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Action',
          value: entity.action.name.cleaned ?? '---',
        ),
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Permit] {entity}, also handles basic available behavior.
final class PermitsEntityTable extends FoundationEntityTableB<PermitsEntityTableAdapter> {
  /// Creates a new [PermitsEntityTable] instance.
  const PermitsEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Permit, PermitsServiceI>(
      entityFactory: () => Permit(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<Permit>>[
        /// --> Name
        EntityTableColumnOptions<Permit>(
          title: 'Name',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.name,
        ),
         /// --> Enabled
        EntityTableColumnOptions<Permit>(
          title: 'Enabled',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.enabled? 'Yes' : 'No',
        ),
         /// --> Solution
        EntityTableColumnOptions<Permit>(
          title: 'Solution',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.solution.name,
        ),
         /// --> Feature
        EntityTableColumnOptions<Permit>(
          title: 'Feature',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.feature.name,
        ),
         /// --> Action
        EntityTableColumnOptions<Permit>(
          title: 'Action',
          factory: (Permit entity, int index, BuildContext buildContext) => entity.action.name,
        ),
      ],
    );
  }
}
