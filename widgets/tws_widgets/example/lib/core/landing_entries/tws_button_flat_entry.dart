part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsButtonFlatEntry = CSMPackageLandingEntry(
  name: "TWSButtonFlat", 
  description: RichText(
    text: TextSpan(
      text:
          "Simple stylish button. \nThis component has the same color scheme in dark and light themes.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSButtonFlat(
      onTap: () => print("TWSButtonFlat: Tap..."),
    );
  }
);