import 'dart:convert';

import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:example/core/const/image_base64.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeBase>
twsImageViewerEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS Image Viewer",
  description:
      (TWSFThemeBase theme, Color foreColor) => TextSpan(
        text:
            "Displays an image component, that expands the image on tap, based on the display or windows app dimensions.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    return TWSFLandingFrame(
      child: TWSImageViewer(img: base64Decode(base64Image)),
    );
  },
);
