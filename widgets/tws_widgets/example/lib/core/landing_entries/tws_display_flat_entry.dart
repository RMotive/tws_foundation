part of '../landing_view.dart';

CSMPackageLandingEntry _twsDisplayFlatEntry = CSMPackageLandingEntry(
  name: "TWSDisplayFlat", 
  description: RichText(
    text: TextSpan(
      text:
          "Display an stylish flat label component.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSDisplayFlat( 
      display: "Display example",
    );
  }
);