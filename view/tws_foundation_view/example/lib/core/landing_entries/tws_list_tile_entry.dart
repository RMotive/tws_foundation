
import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsListTileEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWS List Tile",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "Simple self-administered statefull list tile. Shows simple text data and updates it's internal state on mouse events.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    return TWSFLandingFrame(
      width: 400,
      child: TwsListTile(
        textColor:
            theme.primaryControlColor.foreAlt ?? theme.primaryControlColor.fore,
        backgroundColor: theme.primaryControlColor.accent,
        label: "Tile exmaple",
        onTap: (bool selected) => print("Tile tap..."),
      ),
    );
  },
);
