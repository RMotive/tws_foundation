import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';

import 'package:tws_foundation_view/tws_foundation_view.dart' as view;
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
final class SolutionsEntityTableEntry extends PackageLandingEntryB<LandingThemeB> {
  /// Creates a new [SolutionsEntityTableEntry] instance.
  SolutionsEntityTableEntry({
    super.key,
  }) : super(
         name: 'Solutions Entity Table',
         image: AssetImage(FoundationAssets.tablePreview),
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
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return view.SolutionsEntityTable(
      adapter: view.SolutionsEntityTableAdapter(),
    );
  }
}
