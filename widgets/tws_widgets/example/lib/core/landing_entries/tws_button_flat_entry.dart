part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsButtonFlatEntry = CSMPackageLandingEntry(
  name: "TWSButtonFlat", 
  description: RichText(
    text: TextSpan(
      text:
          "Simple TWS Custom action button with async capabilities. \nThis component has the same color scheme in dark and light themes.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: CSMSpacingRow(
        spacing: 20,
        children: <Widget>[
          Expanded(
            child: TWSButtonFlat(
              label: 'Native onTap',
              onTap: () => print("TWSButtonFlat: Tap..."),
            ),
          ),
          Expanded(
            child: TWSButtonFlat(
              label: 'Async onTap',
              onTap: () async {
                print('waiting...');
                await Future<void>.delayed(Duration(seconds: 2));
                print("TWSButtonFlat: Tap...");
              },
            ),
          ),
        ],
      ),
    );
  }
);