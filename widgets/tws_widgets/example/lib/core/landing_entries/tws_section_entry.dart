part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsSectionEntry = CSMPackageLandingEntry(
  name: "TWS Section", 
  description: RichText(text: TextSpan(text: "Custom TWS section component"),), 
  composeLanding: (BuildContext ctx) {
    return TWSSection(
      title: "Section Example", 
      content: Container(),
    );
  }
);