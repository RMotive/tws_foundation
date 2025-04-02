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
      child: CSMSpacingRow(
        spacing: 20,
        children: <Widget>[
          Expanded(
            child: TwsSelectableList<Feature>(
              title: "FutureOr callback Selectable List",
              tileTitle: (Feature value) => "value: ${value.name}",
              adapter: ViewConsumeAdapter(),
              onSelect:(bool selected, Feature item) async {
                print('waiting...');
                await Future<void>.delayed(Duration(seconds: 1));
                print("selected: $selected - ${item.name}");
              },
            ),
          ),
          Expanded(
            child: TwsSelectableList<Feature>(
              title: "TWS Selectable List",
              tileTitle: (Feature value) => "value: ${value.name}",
              adapter: ViewConsumeAdapter(),
              onSelect:(bool selected, Feature item) {
                print("selected: $selected - ${item.name}");
              },
            ),
          ),
        ],
      )
    );
  }
);

