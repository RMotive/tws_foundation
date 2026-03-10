import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements a custom [EntityTableAdapterB] for a [Solution] based [EntityTable] providing a foundation
/// {csm} data handling table for [Solution].
final class SolutionsEntityTableAdapter extends FoundationEntityTableAdapterB<Solution> {
  /// Creates a new [SolutionsEntityTableAdapter] instance.
  SolutionsEntityTableAdapter({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Solution entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: <Widget>[
        /// --> Name property viewer
        PropertyViewer<String>(
          label: 'Sign',
          value: entity.sign,
        ),

        PropertyViewer<String>(
          label: 'Name',
          value: entity.name,
        ),

        PropertyViewer<String>(
          label: 'Description',
          value: entity.description,
        ),

        PropertyViewer<String>(
          label: 'Timestamp',
          value: entity.timestamp.fullDate,
        ),
      ],
    );
  }

  @override
  EntityTableAdapterEditor<Solution>? composeEditor() {
    return EntityTableAdapterEditor<Solution>(
      onUpdate: (EntityTableAdapterEditorData<Solution> data) {

        showDialog(
          context: data.context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              acceptLabel: 'Update',
              title: 'Confirm Solution Update',
              content: Text.rich(
                TextSpan(
                  text: 'Are you sure you want to update solution ',
                  children: <InlineSpan>[
                    TextSpan(
                      text: '(${data.entity.sign}):',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const TextSpan(
                      text: '\n',
                    ),
                    const TextSpan(
                      text: '\n\u2022 Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    WidgetSpan(
                      baseline: TextBaseline.alphabetic,
                      alignment: PlaceholderAlignment.bottom,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text('\n${data.entity.description}'),
                      ),
                    ),
                  ],
                ),
              ),
              onAccept: () async {
                SolutionsServiceI solutionsService = InjectorUtils.get();

                String authToken = await composeAuth();

                FoundationResponseResolver<UpdateOutput<Solution>> resResolver = await solutionsService.update(
                  UpdateInput<Solution>(data.entity),
                  authToken,
                );

                String? errMessage;
                resResolver.resolve(
                  factory:
                      () => UpdateOutput<Solution>(
                        () => Solution(),
                      ),
                  onSuccess: (SuccessFrame<UpdateOutput<Solution>> success) {
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
                      context: data.context,
                      useRootNavigator: true,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          showCancelButton: false,
                          title: 'Error Updating Solution',
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
              },
            );
          },
        );
      },
      formBuilder: (EntityTableAdapterEditorData<Solution> data) {
        return Column(
          spacing: 18,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// --> Sign Property Input
            TextInput(
              label: 'Sign',
              isEnabled: false,
              maxLength: 5,
              controller: TextEditingController(
                text: data.entity.sign,
              ),
            ),

            /// --> Name Property Input
            TextInput(
              label: 'Name',
              isEnabled: false,
              controller: TextEditingController(
                text: data.entity.name,
              ),
            ),

            /// --> Description Property Input
            TextInput(
              label: 'Description',
              controller: TextEditingController(
                text: data.entity.description,
              ),
              onChanged: (String newDescription) => data.entity.description = newDescription,
            ),

            /// --> Timestamp Property Input
            PropertyViewer<String>(
              label: 'Timestamp',
              value: data.entity.timestamp.fullDate,
            ),
          ],
        );
      },
    );
  }
}

/// {widget} class.
///
/// Draws a {CSM} foundation [Solution] based [EntityTable], providing default interactions and management for [Solution] entity.
final class SolutionsEntityTable extends StatelessWidget {
  /// Table adapter handler.
  final SolutionsEntityTableAdapter adapter;

  /// Creates a new [SolutionsEntityTable] instance.
  const SolutionsEntityTable({
    super.key,
    required this.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Solution, ResponseResolverBase<ViewOutput<Solution>>, SolutionsServiceI>(
      adapter: adapter,
      factory: () => Solution(),
      columns: <EntityTableColumnData<Solution>>[
        EntityTableColumnData<Solution>(
          title: 'Sign',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.sign,
        ),
        EntityTableColumnData<Solution>(
          title: 'Name',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.name,
        ),
        EntityTableColumnData<Solution>(
          title: 'Description',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.description,
        ),
      ],
    );
  }
}
