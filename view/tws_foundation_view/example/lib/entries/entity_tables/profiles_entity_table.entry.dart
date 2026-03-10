import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';

import 'package:tws_foundation_view/tws_foundation_view.dart' as view;
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
final class ProfilesEntityTableEntry extends PackageLandingEntryBase<LandingThemeB> {
  /// Creates a new [ProfilesEntityTableEntry] instance.
  ProfilesEntityTableEntry({
    super.key,
  }) : super(
         name: 'Profiles Entity Table',
         image: AssetImage(FoundationAssets.tablePreview),
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'Foundation {CSM} Entity Table representing [Profile] entity data and interactions, handles foundation possible interactions related with [Profile] data management, like details drawer viewer, inline entity edition, entity remotion, etc.',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return view.ProfilesEntityTable(
      adapter: view.ProfilesEntityTableAdapter(),
    );
  }
}
