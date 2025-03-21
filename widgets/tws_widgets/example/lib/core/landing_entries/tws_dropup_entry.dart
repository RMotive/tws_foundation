part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsDropupEntry = CSMPackageLandingEntry(
  name: "TWS Dropup", 
  description: RichText(text: TextSpan(text: "Custom TWS Dropup component"),), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSDropup<int>(
        item: 2, 
        items: <int>[1,2,3,4,5,6], 
        tooltip: "tooltip",
        onChange:(int item) {
          print("Selected item: $item");
        },
      ),
    );
  }
);