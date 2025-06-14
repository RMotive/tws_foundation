import 'package:csm_view/csm_view.dart';
import 'package:example/core/landing_utils.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';

import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

///
final class YardLogsEntityTableEntry extends PackageLandingEntryB<LandingThemeB> {
  /// Creates a new [YardLogsEntityTableEntry] instance.
  YardLogsEntityTableEntry({
    super.key,
  }) : super(
         name: 'Yard Logs Entity Table',
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'Foundation {CSM} Entity Table representing [YardLog] entity data and interactions, handles foundation possible interactions related with [YardLog] data management, like details drawer viewer, inline entity edition, entity remotion, etc.',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, PackageLandingThemeB theme) {
    return view.YardLogsEntityTable(
      adapter: view.YardLogsEntityTableAdapter(
        authBuilder: LandingUtils.authBuilder,
      ),
    );
  }
}
