import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

///
final class EntityTable extends PackageLandingEntryB<LandingThemeB> {
  /// Creates a new [EntityTable] instance.
  EntityTable({
    super.key,
  }) : super(
         name: 'Entity Table',
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'Draws a complex data table widget for a business entity base, filtering, ordering and searching entity items',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, PackageLandingThemeB theme) {
    return view.EntityTable<Solution, SolutionsServiceI>(
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
      columns: <view.EntityTableColumnOptions<Solution>>[
        
        view.EntityTableColumnOptions<Solution>(
          title: 'Sign',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.sign,
        ),
        view.EntityTableColumnOptions<Solution>(
          title: 'Name',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.name,
        ),
        view.EntityTableColumnOptions<Solution>(
          title: 'Description',
          factory: (Solution entity, int index, BuildContext buildContext) => entity.description,
        ),
      ],
    );
  }
}
