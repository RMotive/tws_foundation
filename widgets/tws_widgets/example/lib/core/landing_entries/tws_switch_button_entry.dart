part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsSwitchButtonEntry = CSMPackageLandingEntry(
  name: "TWS Switch Button", 
  description: RichText(
    text: TextSpan(
      text:
          "This widget returns a boolean, based on the its state.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: CSMSpacingRow(
        spacing: 20,
        children: <Widget>[
          Expanded(
            child: TWSSwitchButton(
              title: "Switch example",
              onChanged: (bool p0) {
                print(p0);
              },
            ),
          ),
          Expanded(
            child: TWSSwitchButton(
              title: "FutureOr Switch example",
              onChanged: (bool p0) async {
                print('waiting....');
                await Future<void>.delayed(Duration(seconds: 1));
                print('finished: true');
              },
            ),
          ),
        ],
      )
    );
  }
);

