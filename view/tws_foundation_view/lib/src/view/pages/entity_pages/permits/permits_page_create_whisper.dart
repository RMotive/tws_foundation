import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {whisper} class.
final class PermitsPageCreateWhisper extends PageB {

  /// Creates a new [PermitsPageCreateWhisper] instance.
  const PermitsPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();
    return Whisper(
      title: 'Create Permit(s)',
      onPerform: () {
        creationController.create();
      },
      child: (GlobalKey<FormState> formState) {
        return CreateEntityForm<Permit, PermitsServiceI>(
          entityFactory: () => Permit(),
          controller: creationController,
          buildEntityTag: (Permit entity) {
            return 'Permit with name: ${entity.name}';
          },
          recordDesigner: (Permit entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField>[

                /// --> Permit name.
                CreateEntityFormRecordField(
                  label: '*Reference code',
                  value: entity.reference.cleaned ?? '---',
                ),

                /// --> Permit name.
                CreateEntityFormRecordField(
                  label: '*Name',
                  value: entity.name,
                ),

                /// --> Permit description.
                CreateEntityFormRecordField(
                  label: 'Description',
                  value: entity.description.cleaned ?? '---',
                ),
                
                /// --> Permit enabled status.
                CreateEntityFormRecordField(
                  label: '*Enabled',
                  value: entity.enabled? 'Yes' : 'No',
                ),

                /// --> Solution.
                CreateEntityFormRecordField(
                  label: 'Solution',
                  value: entity.solution.name.cleaned ?? '---',
                ),

                /// --> Feature.
                CreateEntityFormRecordField(
                  label: 'Feature',
                  value: entity.feature.name.cleaned ?? '---',
                ),

                /// --> Action.
                CreateEntityFormRecordField(
                  label: 'Action',
                  value: entity.action.name.cleaned ?? '---',
                ),
                
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Permit>? itemState) {
            final bool formDisabled = !(itemState == null);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 12,
                  children: <Widget>[
                    /// --> Permits enabled status
                    OptionsSelector<bool>(
                      height: 100,
                      title: 'Enabled',
                      preSelected: <bool>[itemState!.entity.enabled],
                      options: <OptionsSelectorOption<bool>>[
                        OptionsSelectorOption<bool>(
                          title: 'Enabled',
                          value: true,
                        ),
                        OptionsSelectorOption<bool>(
                          title: 'Disabled',
                          value: false,
                        ),
                      ],
                      onSelect: (List<bool> selected) {
                        itemState.entity.enabled = selected.first;
                      },
                    ),
                    Row(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// --> Reference code
                        Expanded(
                          child: TextInput(
                            label: '*Reference code',
                            isEnabled: formDisabled,
                            maxLength: 8,
                            isFixedLength: true,
                            controller: TextEditingController(
                              text: itemState.entity.reference,
                            ),
                            onChanged: (String text) {
                              Permit permit = itemState.entity;
                              permit.reference = text;
                              itemState.react();
                            },
                          ),
                        ),

                        /// --> Contact Name
                        Expanded(
                          child: TextInput(
                            label: '*Name',
                            isEnabled: formDisabled,
                            maxLength: 100,
                            controller: TextEditingController(
                              text: itemState.entity.name,
                            ),
                            onChanged: (String text) {
                              Permit permit = itemState.entity;
                              permit.name = text;
                              itemState.react();
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      spacing: 10,
                      children: <Widget>[

                        /// --> Description
                        Expanded(
                          child: TextInput(
                            label: 'Description',
                            isEnabled: formDisabled,
                            maxLength: 200,
                            controller: TextEditingController(
                              text: itemState.entity.description,
                            ),
                            onChanged: (String text) {
                              Permit permit = itemState.entity;
                              permit.description = text.cleaned;
                              itemState.react();
                            },
                          ),
                        ),

                        /// --> Solution
                        Expanded(
                          child: EntityFinderSelector<Solution, SolutionsServiceI>(
                            entityBuilder: () => Solution(),
                            label: 'Select a Solution...',
                            initialValue: itemState.entity.solution,
                            textBuilder: (Solution solution) {
                              return solution.name;
                            },
                            onSelected: (Solution? solution) {
                              itemState.entity.solution = solution ?? Solution();
                              itemState.react();
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      spacing: 10,
                      children: <Widget>[
                        /// --> Feature
                        Expanded(
                          child: EntityFinderSelector<Feature, FeaturesServiceI>(
                            entityBuilder: () => Feature(),
                            label: 'Select a Feature...',
                            initialValue: itemState.entity.feature,
                            textBuilder: (Feature feature) {
                              return feature.name;
                            },
                            onSelected: (Feature? feature) {
                              itemState.entity.feature = feature ?? Feature();
                              itemState.react();
                            },
                          ),
                        ),
                        /// --> Feature
                        Expanded(
                          child: EntityFinderSelector<Action, ActionsServiceI>(
                            entityBuilder: () => Action(),
                            label: 'Select an Action...',
                            initialValue: itemState.entity.action,
                            textBuilder: (Action action) {
                              return action.name;
                            },
                            onSelected: (Action? action) {
                              itemState.entity.action = action ?? Action();
                              itemState.react();
                            },
                          ),
                        ),
                      ],
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
