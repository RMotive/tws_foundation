import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeBase>
twsPhotoTakerEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS Photo taker",
  description:
      (TWSFThemeBase theme, Color foreColor) => TextSpan(
        text:
            "This component can access to the device camera and picture storage to take photos or select stores images.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    return TWSPhotoTaker();
  },
);
