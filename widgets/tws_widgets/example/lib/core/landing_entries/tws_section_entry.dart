part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsSectionEntry = CSMPackageLandingEntry(
  name: "TWS Section", 
  description: RichText(
    text: TextSpan(
      text: "Defined to handle section separator along pages sections.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSSection(
        title: "Section Example", 
        content: Container(),
      ),
    );
  }
);