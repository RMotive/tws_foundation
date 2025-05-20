
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsFrameDecorationEntry = PackageLandingEntry<TWSFThemeB>(
      name: "TWS Frame Decoration",
      description:
          (TWSFThemeB theme, Color foreColor) => TextSpan(
            text: "Shows an stylized frame decoration wrap for other widgets.",
          ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
        return TWSFrameDecoration(child: Container(height: 50));
      },
    );
