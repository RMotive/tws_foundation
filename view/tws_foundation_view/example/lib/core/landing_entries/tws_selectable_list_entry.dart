import 'package:csm_view/csm_view.dart';
import 'package:example/core/adapters/view_consume_adapters.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsSelectableListEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWS Selectable List",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "Display a list of selectable items getted from a [TWSViewConsumeAdapter] class",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    return Row(
      spacing: 20,
      children: <Widget>[
        Expanded(
          child: TwsSelectableList<TrailerClass>(
            title: "FutureOr callback Selectable List",
            tileTitle: (TrailerClass value) => "value: ${value.name}",
            adapter: ViewConsumeAdapter(),
            onSelect: (bool selected, TrailerClass item) async {
              print('waiting...');
              await Future<void>.delayed(Duration(seconds: 1));
              print("selected: $selected - ${item.name}");
            },
          ),
        ),
        Expanded(
          child: TwsSelectableList<TrailerClass>(
            title: "TWS Selectable List",
            tileTitle: (TrailerClass value) => "value: ${value.name}",
            adapter: ViewConsumeAdapter(),
            onSelect: (bool selected, TrailerClass item) {
              print("selected: $selected - ${item.name}");
            },
          ),
        ),
      ],
    );
  },
);

