import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

PackageLandingEntry<TWSFThemeBase>
twsConfirmationDialogEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS Confirmation Dialog",
  description:
      (TWSFThemeBase theme, Color foreColor) => TextSpan(
        text:
            "Displays a dialog window with a header, body content and confirmation action buttons.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
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
