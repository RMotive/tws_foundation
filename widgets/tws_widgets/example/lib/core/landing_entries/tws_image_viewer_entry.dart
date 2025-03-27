part of '../landing_view/landing_view.dart';


CSMPackageLandingEntry _twsImageViewerEntry = CSMPackageLandingEntry(
  name: "TWS Image Viewer", 
  description: RichText(
    text: TextSpan(
      text:
          "Displays an image component, that expands the image on tap, based on the display or windows app dimensions.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSImageViewer(
        img: base64Decode(base64Image),
      ),
    );
  }
);