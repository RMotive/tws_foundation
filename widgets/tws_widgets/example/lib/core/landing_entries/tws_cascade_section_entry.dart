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
      child: CSMSpacingRow(
        spacing: 20,
        children: <Widget>[
          Expanded(
            child: TWSCascadeSection(
              title: "Cascade Example", 
              mainControl: Container(
                color: Colors.green,
                child: Text("Main control section"),
              ), 
              loadOnPress:(bool isShowing) {
                return Container(
                  height: 300,
                  color: Colors.red,
                );
              },
            ),
          ),
          Expanded(
            child: TWSCascadeSection(
              title: "Cascade FutureOr Example", 
              mainControl: Container(
                color: Colors.green,
                child: Text("Main control section"),
              ), 
              loadOnPress:(bool isShowing) async {
                if(isShowing) {
                  await Future<void>.delayed(Duration(seconds: 1));
                  print('loaded....');
                }

                return Container(
                  height: 300,
                  color: Colors.red,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
);
