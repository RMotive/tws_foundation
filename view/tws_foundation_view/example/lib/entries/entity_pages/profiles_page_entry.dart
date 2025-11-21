 import 'package:csm_view/csm_view.dart' hide LandingThemeB;
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {entry} class.
///
/// Implements a [PackageLandingEntryB] for [ProfilesPage] from {tws_foundation_view} package as part of the package landing playground.
final class  ProfilesPageEntry extends PackageLandingEntryB<LandingThemeB> {
  /// Creates a new [ProfilesPage] instance.
  ProfilesPageEntry({
    super.key,
  }) : super(
         name: 'Profiles Page',
         image: AssetImage(FoundationAssets.pagePreview),
         description: (LandingThemeB theme, Color foreColor) {
           return TextSpan(
             text: 'A Profiles page provides visual interaction with the security entity management operations',
             style: TextStyle(
               color: foreColor,
             ),
           );
         },
       );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return ProfilesPage(
      adapter: ProfilesEntityTableAdapter(),
    );
  }
}
