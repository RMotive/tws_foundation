import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> wsPropertyViewerEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWS Property viewer",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "Shows a text format for properties: Property title and the property value.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    return TWSPropertyViewer(label: "label example", value: "content");
  },
);
