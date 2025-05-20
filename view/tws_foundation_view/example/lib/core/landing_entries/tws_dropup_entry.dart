import 'package:csm_view/csm_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsDropupEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWS Dropup",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "Displays a interactable control. When this control is tapped, deploy an aditional section in a drop up animation.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    return Row(
      spacing: 20,
      children: <Widget>[
        Expanded(
          child: TWSSection(
            title: 'TWS DropUp',
            content: Center(
              child: TWSDropup<int>(
                item: 2,
                items: <int>[1, 2, 3, 4, 5, 6],
                tooltip: "tooltip",
                onChange: (int item) {
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
                items: <int>[1, 2, 3, 4, 5, 6],
                tooltip: "tooltip",
                onChange: (int item) async {
                  await Future<void>.delayed(Duration(seconds: 1));
                  print("loaded selected item: $item");
                },
              ),
            ),
          ),
        ),
      ],
    );
  },
);
