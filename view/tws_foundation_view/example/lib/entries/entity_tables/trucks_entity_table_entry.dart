
import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';

import 'package:tws_foundation_view/tws_foundation_view.dart' as view;
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
final class TrucksEntityTableEntry extends PackageLandingEntryBase<LandingThemeB> {
  /// Creates a new [TrucksEntityTableEntry] instance.
  TrucksEntityTableEntry({
    super.key,
  }) : super(
         name: 'Trucks Entity Table',
         image: AssetImage(FoundationAssets.tablePreview),
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'Foundation {CSM} Entity Table representing [Truck_Common] entity data and interactions, handles foundation possible interactions related with [Truck_Common] data management, like details drawer viewer, inline entity edition, entity remotion, etc.',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return view.TrucksEntityTable(
      adapter: view.TrucksEntityTableAdapter(),
    );
  }
}
