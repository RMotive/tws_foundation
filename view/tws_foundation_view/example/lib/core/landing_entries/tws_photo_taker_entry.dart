import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsPhotoTakerEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWS Photo taker",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "This component can access to the device camera and picture storage to take photos or select stores images.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    return TWSPhotoTaker();
  },
);
