part of '../landing_view.dart';

CSMPackageLandingEntry _twsFrameDecorationEntry = CSMPackageLandingEntry(
  name: "TWS Frame Decoration", 
  description: RichText(text: TextSpan(text: "Custom TWS Frame Decoration component"),), 
  composeLanding: (BuildContext ctx) {
    return TWSFrameDecoration(
      child: Container(
        height: 50,
      ),
    );
  }
);