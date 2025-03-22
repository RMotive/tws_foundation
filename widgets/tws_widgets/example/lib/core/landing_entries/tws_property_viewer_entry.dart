part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsPropertyViewerEntry = CSMPackageLandingEntry(
  name: "TWS Property viewer",
  description: RichText(
    text: TextSpan(
      text:
          "Shows a text format for properties: Property title and the property value.",
    ),
  ),
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      width: 600,
      child: TWSPropertyViewer(
        label: "label example", 
        value: "content",
      ),
    );
  },
);
