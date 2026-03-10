import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {entry} class.
///
/// Implements a [PackageLandingEntryBase] for [SectionsPage] from {tws_foundation_view} package as part of the package landing playground.
final class SectionsPageEntry extends PackageLandingEntryBase<LandingThemeB> {
  /// Creates a new [SectionsPageEntry] instance.
  SectionsPageEntry({
    super.key,
  }) : super(
         name: 'Sections Page',
         image: AssetImage(FoundationAssets.pagePreview),
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text: 'A Sections page provides visual interaction with the business entity management operations',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return SectionsPage(
      adapter: SectionsEntityTableAdatper(),
    );
  }
}
