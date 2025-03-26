part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsPhotoTakerEntry = CSMPackageLandingEntry(
  name: "TWS Photo taker",
  description: RichText(
    text: TextSpan(
      text:
          "Widget Row that shows paging data and paging selector. Ideal for data tables.",
    ),
  ),
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      width: 400,
      child: TWSPhotoTaker(),
    );
  },
);
