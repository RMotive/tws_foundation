import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsConfirmationDialogEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWS Confirmation Dialog",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "Displays a dialog window with a header, body content and confirmation action buttons.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    return TWSFLandingFrame(
      width: 300,
      child: TWSButtonFlat(
        label: "Show dialog",
        onTap: () {
          showDialog(
            context: ctx,
            builder: (BuildContext context) {
              return TWSConfirmationDialog(
                onClose: () => print("Closing dialog...."),
                onAccept: () => print("Tap on Ok button...."),
              );
            },
          );
        },
      ),
    );
  },
);
