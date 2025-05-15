
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

PackageLandingEntry<TWSFThemeBase> twsFrameDecorationEntry =
    PackageLandingEntry<TWSFThemeBase>(
      name: "TWS Frame Decoration",
      description:
          (TWSFThemeBase theme, Color foreColor) => TextSpan(
            text: "Shows an stylized frame decoration wrap for other widgets.",
          ),
      contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
        return TWSFrameDecoration(child: Container(height: 50));
      },
    );
