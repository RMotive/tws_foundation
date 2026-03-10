import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {entry} class.
///
/// Implements a [PackageLandingEntryBase] for [PermitsPage] from {tws_foundation_view} package as part of the package landing playground.
final class  PermitsPageEntry extends PackageLandingEntryBase<LandingThemeB> {
  /// Creates a new [PermitsPage] instance.
  PermitsPageEntry({
    super.key,
  }) : super(
         name: 'Permits Page',
         image: AssetImage(FoundationAssets.pagePreview),
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text: 'A Permits page provides visual interaction with the security entity management operations',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return PermitsPage(
      adapter: PermitsEntityTableAdapter(),
    );
  }
}
