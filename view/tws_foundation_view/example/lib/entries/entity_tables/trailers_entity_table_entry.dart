
import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';

import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

///
final class TrailersEntityTableEntry extends PackageLandingEntryB<LandingThemeB> {
  /// Creates a new [TrailersEntityTableEntry] instance.
  TrailersEntityTableEntry({
    super.key,
  }) : super(
         name: 'Trailers Entity Table',
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'Foundation {CSM} Entity Table representing [Trailer_Common] entity data and interactions, handles foundation possible interactions related with [Trailer_Common] data management, like details drawer viewer, inline entity edition, entity remotion, etc.',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return view.TrailersEntityTable(
      adapter: view.TrailersEntityTableAdapter(),
    );
  }
}
