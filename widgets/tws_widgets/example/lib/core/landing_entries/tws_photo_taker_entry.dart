part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsPhotoTakerEntry = CSMPackageLandingEntry(
  name: "TWS Photo taker",
  description: RichText(
    text: TextSpan(
      text:
          "This component can access to the device camera and picture storage to take photos or select stores images.",
    ),
  ),
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      width: 400,
      child: TWSPhotoTaker(),
    );
  },
);
