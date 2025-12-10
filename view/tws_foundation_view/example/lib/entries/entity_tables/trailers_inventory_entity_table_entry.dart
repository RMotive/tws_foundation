import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';

import 'package:tws_foundation_view/tws_foundation_view.dart' as view;
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
final class TrailerInventoryEntityTableEntry extends PackageLandingEntryB<LandingThemeB> {
  /// Creates a new [TrailerInventoryEntityTableEntry] instance.
  TrailerInventoryEntityTableEntry({
    super.key,
  }) : super(
         name: 'Trailer Inventory Table',
         image: AssetImage(FoundationAssets.tablePreview),
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text:
                 'Foundation {CSM} Entity Table representing [YardLog] entity, filtered to show as a trailer inventory data, handles foundation possible interactions related with [Trailer] inventory data view.',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return view.TrailerInventoryEntityTable(
      adapter: view.TrailersInventoryEntityTableAdapter(),
    );
  }
}
