part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsButtonFlatEntry = CSMPackageLandingEntry(
  name: "TWSButtonFlat", 
  description: RichText(
    text: TextSpan(
      text:
          "Simple TWS Custom action button with async capabilities. \nThis component has the same color scheme in dark and light themes.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSButtonFlat(
        width: 200,
        onTap: () => print("TWSButtonFlat: Tap..."),
      ),
    );
  }
);