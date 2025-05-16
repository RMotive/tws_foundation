import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeBase> twsDisplayFlatEntry =
    PackageLandingEntry<TWSFThemeBase>(
      name: "TWSDisplayFlat",
      description:
          (TWSFThemeBase theme, Color foreColor) =>
              TextSpan(text: "Display an stylish flat label component."),
      contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
        return TWSDisplayFlat(display: "Display example");
      },
    );
