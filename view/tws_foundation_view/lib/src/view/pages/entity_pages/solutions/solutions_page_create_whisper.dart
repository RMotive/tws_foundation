import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {whisper} class.
final class SolutionsPageCreateWhisper extends ViewPageBase {

  /// Creates a new [SolutionsPageCreateWhisper] instance.
  const SolutionsPageCreateWhisper();

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();
    return Whisper(
      title: 'Create Solution(s)',
      onPerform: () {
        creationController.create();
      },
      child: (GlobalKey<FormState> formState) {
        return CreateEntityForm<Solution, SolutionsServiceI>(
          factory: () => Solution(),
          controller: creationController,
          authFactory: (BuildContext context) {
            SessionStorage sessionStorage = InjectorUtils.get();
            return sessionStorage.token;
          },
          recordDesigner: (Solution entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField<Object>>[
                CreateEntityFormRecordField<String>(
                  label: 'Name',
                  value: entity.name,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Description',
                  value: entity.description,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Sign',
                  value: entity.sign.cleaned,
                ), 
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<Solution>? itemState, _) {
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
                      /// --> Solution Name
                      Expanded(
                        child: TextInput(
                          label: 'Name',
                          isEnabled: formDisabled,
                          maxLength: 100,
                          controller: TextEditingController(
                            text: itemState?.entity.name,
                          ),
                          onChanged: (String text) {
                            Solution solution = itemState!.entity;
                            solution.name = text;
                            itemState.react();
                          },
                        ),
                      ),

                      /// --> Solution Description
                      Expanded(
                        child: TextInput(
                          label: 'Description',
                          isEnabled: formDisabled,
                          maxLength: 200,
                          controller: TextEditingController(
                            text: itemState?.entity.description,
                          ),
                          onChanged: (String text) {
                            Solution solution = itemState!.entity;
                            solution.description = text;
                            itemState.react();
                          },
                        ),
                      ),
                    ],
                  ),
                  TextInput(
                    width: double.maxFinite,
                    label: 'Sign',
                    isEnabled: formDisabled,
                    maxLength: 5,
                    controller: TextEditingController(
                      text: itemState?.entity.sign,
                    ),
                    onChanged: (String text) {
                      Solution solution = itemState!.entity;
                      solution.sign = text;
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
