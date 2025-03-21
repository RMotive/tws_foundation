part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsFrameDecorationEntry = CSMPackageLandingEntry(
  name: "TWS Frame Decoration", 
  description: RichText(text: TextSpan(text: "Custom TWS Frame Decoration component"),), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSFrameDecoration(
        child: Container(
          height: 50,
        ),
      ),
    );
  }
);