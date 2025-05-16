import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeBase>
twsInputTextEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS Input text",
  description:
      (TWSFThemeBase theme, Color foreColor) => TextSpan(
        text:
            "This component builds a TWS Design opinioned component for a text input control.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    return TWSFLandingFrame(
      child: TWSInputText(
        width: 200,
        label: "label example",
        hint: "Hint example",
        onChanged: (String text) {
          print("typed text: $text");
        },
      ),
    );
  },
);
