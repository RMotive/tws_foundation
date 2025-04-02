part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsOptionsSelectorEntry = CSMPackageLandingEntry(
  name: "TWS Options Selector",
  description: RichText(
    text: TextSpan(
      text:
        "Widget that display a selectable wraped list actions given in [options] property",
    ),
  ),
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: CSMSpacingRow(
        spacing: 20,
        children: <Widget>[
          Expanded(
            child: TWSSection(
              title: 'TWS Options Selector',
              content: Center(
                child: SizedBox(
                  width: 400,
                  child: TwsOptionsSelector<int>(
                    initialValue: 2,
                    options: <TwsOptionSelectorAction<int>>[
                      TwsOptionSelectorAction<int>(
                        title: "value 1", 
                        value: 1,
                        maxWidth: 200,
                      ),
                      TwsOptionSelectorAction<int>(
                        title: "value 2", 
                        value: 2,
                        maxWidth: 200,
                      ),
                      TwsOptionSelectorAction<int>(
                        title: "value 3", 
                        value: 3,
                      ),
                    ], 
                    onSelect:(int value) {
                      print("selected value: $value");
                    },
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: TWSSection(
              title: 'FutureOr TWS Options Selector',
              content: Center(
                child: SizedBox(
                  width: 400,
                  child: TwsOptionsSelector<int>(
                    initialValue: 2,
                    onSelect:(int value) async {
                      await Future<void>.delayed(Duration(seconds: 1));
                      print("loaded... selected value: $value");
                    },
                    options: <TwsOptionSelectorAction<int>>[
                      TwsOptionSelectorAction<int>(
                        title: "value 1", 
                        value: 1,
                        maxWidth: 200,
                      ),
                      TwsOptionSelectorAction<int>(
                        title: "value 2", 
                        value: 2,
                        maxWidth: 200,
                      ),
                      TwsOptionSelectorAction<int>(
                        title: "value 3", 
                        value: 3,
                      ),
                    ], 
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  },
);
