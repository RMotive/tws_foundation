part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsSectionDividerEntry = CSMPackageLandingEntry(
  name: "TWS Section Divider",
  description: RichText(
    text: TextSpan(
      text:
          "Custom divider component to divide the sections or sub-sections.",
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
