import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/widgets/entity_table/entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/widgets/tws_confirmation_dialog.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements a custom [EntityTableAdapterB] for a [Solution] based [EntityTable] providing a foundation
/// {csm} data handling table for [Solution].
final class SolutionsEntityTableAdapter extends EntityTableAdapterB<Solution> {
  /// Callback to get authentication token due to [SolutionsServiceI.update] service needs authorization token,
  /// {FoundationView} package doesn't have authentication or session control.
  final FutureOr<String> Function() authBuilder;

  /// Creates a new [SolutionsEntityTableAdapter] instance.
  SolutionsEntityTableAdapter({
    required this.authBuilder,
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
        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return TWSConfirmationDialog(
              accept: 'Update',
              title: 'Confirm Solution Update',
              statement: Text.rich(
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

                String authToken = await authBuilder();

                await solutionsService.update(
                  UpdateInput<Solution>(entity),
                  authToken,
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
      authGenerator: () async {
        final SecurityServiceI securityService = Injector.get<SecurityServiceI>();

        final FoundationResponseResolver<SessionData> authOutputResolver = await securityService.authenticate(
          AuthenticationInput.a('TWSMF', 'local_user', 'local_user'.bytes),
        );

        return authOutputResolver
            .resolveDirect(
              () => SessionData(),
            )
            .token;
      },
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
