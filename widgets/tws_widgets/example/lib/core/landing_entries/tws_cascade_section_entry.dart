part of '../landing_view/landing_view.dart';
CSMPackageLandingEntry _twsCascadeSectionEntry = CSMPackageLandingEntry(
  name: "TWS Cascade Section", 
  description: RichText(
    text: TextSpan(
      text: "Shows a custom main control widget with a colapsable content section.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      width: 400,
      child: TWSCascadeSection(
        title: "Cascade Example", 
        mainControl: Container(
          color: Colors.green,
          child: Text("Main control section"),
        ), 
        content: Container(
          height: 300,
          color: Colors.red,
        ),
      ),
    );
  }
);
