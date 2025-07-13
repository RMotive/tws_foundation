import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
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
        PropertyViewer(
          label: 'Sign',
          value: entity.sign,
        ),

        PropertyViewer(
          label: 'Name',
          value: entity.name,
        ),

        PropertyViewer(
          label: 'Description',
          value: entity.description,
        ),

        PropertyViewer(
          label: 'Timestamp',
          value: entity.timestamp.fullDateString,
        ),
      ],
    );
  }

  @override
  EntityTableAdapterEditor<Solution>? composeEditor() {
    return EntityTableAdapterEditor<Solution>(
      onUpdate: (BuildContext buildContext, Solution entity) {
        final Router router = Injector.get();

        showDialog(
          context: buildContext,
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
                      text: '(${entity.sign}):',
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
                        child: Text('\n${entity.description}'),
                      ),
                    ),
                  ],
                ),
              ),
              onAccept: () async {
                SolutionsServiceI solutionsService = Injector.get();

                String authToken = await composeAuth();

                FoundationResponseResolver<UpdateOutput<Solution>> resResolver = await solutionsService.update(
                  UpdateInput<Solution>(entity),
                  authToken,
                );

                String? errMessage;
                resResolver.resolve(
                  objectBuilder:
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
                    router.pop();
                    if (errMessage == null) return;

                    showDialog(
                      context: buildContext,
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
                          theming: Theming.get<FoundationThemeB>(context).error,
                          onAccept: () {
                            router.pop();
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
      formBuilder: (BuildContext buildContext, Solution entity) {
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
                text: entity.sign,
              ),
            ),

            /// --> Name Property Input
            TextInput(
              label: 'Name',
              isEnabled: false,
              controller: TextEditingController(
                text: entity.name,
              ),
            ),

            /// --> Description Property Input
            TextInput(
              label: 'Description',
              controller: TextEditingController(
                text: entity.description,
              ),
              onChanged: (String newDescription) => entity.description = newDescription,
            ),

            /// --> Timestamp Property Input
            PropertyViewer(
              label: 'Timestamp',
              value: entity.timestamp.fullDateString,
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
    return EntityTable<Solution, SolutionsServiceI>(
      adapter: adapter,
      entityFactory: () => Solution(),
      columns: <EntityTableColumnOptions<Solution>>[
        EntityTableColumnOptions<Solution>(
          title: 'Sign',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.sign,
        ),
        EntityTableColumnOptions<Solution>(
          title: 'Name',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.name,
        ),
        EntityTableColumnOptions<Solution>(
          title: 'Description',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.description,
        ),
      ],
    );
  }
}
