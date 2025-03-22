part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsSelectableListEntry = CSMPackageLandingEntry(
  name: "TWS Selectable List", 
  description: RichText(
    text: TextSpan(
      text:
          "Display a list of selectable items getted from a [TWSViewConsumeAdapter] class",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TwsSelectableList<Feature>(
        title: "title example",
        tileTitle: (Feature value) => "value: ${value.name}",
        adapter: ViewConsumeAdapter(),
        onSelect:(bool selected, Feature item) {
          print("selected: $selected - ${item.name}");
        },
      )
    );
  }
);

