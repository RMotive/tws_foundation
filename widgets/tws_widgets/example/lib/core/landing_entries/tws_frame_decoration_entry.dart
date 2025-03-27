part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsFrameDecorationEntry = CSMPackageLandingEntry(
  name: "TWS Frame Decoration", 
  description: RichText(
    text: TextSpan(
      text: " Shows an stylized frame decoration wrap for other widgets. ",
    ),
  ), 
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