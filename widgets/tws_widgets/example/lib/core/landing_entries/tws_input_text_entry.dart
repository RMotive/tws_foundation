part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsInputTextEntry = CSMPackageLandingEntry(
  name: "TWS Input text",
  description: RichText(
    text: TextSpan(
      text:
          "This component builds a TWS Design opinioned component for a text input control.",
    ),
  ),
  composeLanding: (BuildContext ctx) {

    return TWSFLandingFrame(
      child: TWSInputText(
        width: 200,
        label: "label example",
        hint: "Hint example",
        onChanged: (String text) {
          print("typed text: $text");
        },
      ),
    );
  },
);
