part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsDisplayFlatEntry = CSMPackageLandingEntry(
  name: "TWSDisplayFlat", 
  description: RichText(
    text: TextSpan(
      text:
          "Display an stylish flat label component.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSDisplayFlat( 
        display: "Display example",
      ), 
    );
  }
);