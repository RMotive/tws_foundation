
import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsButtonFlatEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWSButtonFlat",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "Simple TWS Custom action button with async capabilities. \nThis component has the same color scheme in dark and light themes.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    return TWSFLandingFrame(
      child: Row(
        spacing: 20,
        children: <Widget>[
          Expanded(
            child: TWSButtonFlat(
              label: 'Native onTap',
              onTap: () => print("TWSButtonFlat: Tap..."),
            ),
          ),
          Expanded(
            child: TWSButtonFlat(
              label: 'Async onTap',
              onTap: () async {
                print('waiting...');
                await Future<void>.delayed(Duration(seconds: 2));
                print("TWSButtonFlat: Tap...");
              },
            ),
          ),
        ],
      ),
    );
  },
);
