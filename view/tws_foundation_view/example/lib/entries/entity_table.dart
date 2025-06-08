import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

///
final class SolutionsEntityTable extends PackageLandingEntryB<LandingThemeB> {
  /// Creates a new [SolutionsEntityTable] instance.
  SolutionsEntityTable({
    super.key,
  }) : super(
         name: 'Solutions Entity Table',
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'Foundation {CSM} Entity Table representing [Solution] entity data and interactions, handles foundation possible interactions related with [Solutions] data management, like details drawer viewer, inline entity edition, entity remotion, etc.',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, PackageLandingThemeB theme) {
    return view.SolutionsEntityTable(
      adapter: view.SolutionsEntityTableAdapter(
        authBuilder: () async {
          SecurityServiceI securityService = Injector.get();

          FoundationResponseResolver<SessionData> resResolver = await securityService.authenticate(
            AuthenticationInput.a('TWSFV', 'local_user', 'local_user'.bytes),
          );

          SessionData sessionData = resResolver.resolveDirect(
            () => SessionData(),
          );

          return sessionData.token;
        },
      ),
    );
  }
}
