part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsSectionDividerEntry = CSMPackageLandingEntry(
  name: "TWS Section Divider",
  description: RichText(
    text: TextSpan(
      text:
          "Shows a text format for properties: Property title and the property value.",
    ),
  ),
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      width: 600,
      child: TWSSectionDivider(
        text: "Divider example",
      ),
    );
  },
);
