part of '../landing_view/landing_view.dart';


CSMPackageLandingEntry _twsImageViewerEntry = CSMPackageLandingEntry(
  name: "TWS Image Viewer", 
  description: RichText(
    text: TextSpan(text: "Custom TWS Image Viewer component"),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSImageViewer(
        img: base64Decode(base64Image),
      ),
    );
  }
);