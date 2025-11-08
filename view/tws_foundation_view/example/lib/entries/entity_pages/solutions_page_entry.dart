import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {entry} class.
///
/// Implements a [PackageLandingEntryB] for [SolutionsPage] from {tws_foundation_view} package as part of the package landing playground.
final class SolutionsPageEntry extends PackageLandingEntryB<LandingThemeB> {
  /// Creates a new [SolutionsPageEntry] instance.
  SolutionsPageEntry({
    super.key,
  }) : super(
         name: 'Solutions Page',
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text: 'A Solutions page provides visual interaction with the business entity management operations',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return SolutionsPage(
      adapter: SolutionsEntityTableAdapter(),
    );
  }
}
