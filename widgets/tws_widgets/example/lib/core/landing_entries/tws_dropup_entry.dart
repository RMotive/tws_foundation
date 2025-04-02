part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsDropupEntry = CSMPackageLandingEntry(
  name: "TWS Dropup", 
  description: RichText(
    text: TextSpan(
      text:
          "Displays a interactable control. When this control is tapped, deploy an aditional section in a drop up animation.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: CSMSpacingRow(
        spacing: 20,
        children: <Widget>[
          Expanded(
            child: TWSSection(
              title: 'TWS DropUp',
              content: Center(
                child: TWSDropup<int>(
                  item: 2, 
                  items: <int>[1,2,3,4,5,6], 
                  tooltip: "tooltip",
                  onChange:(int item) {
                    print("Selected item: $item");
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: TWSSection(
              title: 'Future TWS DropUp', 
              content: Center(
                child: TWSDropup<int>(
                  item: 2, 
                  items: <int>[1,2,3,4,5,6], 
                  tooltip: "tooltip",
                  onChange:(int item) async {
                    await Future<void>.delayed(Duration(seconds: 1));
                    print("loaded selected item: $item");
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
);