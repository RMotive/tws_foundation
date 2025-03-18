part of '../landing_view.dart';
CSMPackageLandingEntry _twsCascadeSectionEntry = CSMPackageLandingEntry(
  name: "TWS Cascade Section", 
  description: RichText(
    text: TextSpan(
      text: "Custom TWS Cascade Section component",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return Column(
      children: <Widget>[
        TWSCascadeSection(
          title: "Cascade Example", 
          mainControl: Container(), 
          content: Container(
            height: 300,
          ),
        ),
      ],
    );
  }
);
