import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsOptionsSelectorEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWS Options Selector",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "Widget that display a selectable wraped list actions given in [options] property",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    return Row(
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
                    TwsOptionSelectorAction<int>(title: "value 3", value: 3),
                  ],
                  onSelect: (int value) {
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
                  onSelect: (int value) async {
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
                    TwsOptionSelectorAction<int>(title: "value 3", value: 3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  },
);
