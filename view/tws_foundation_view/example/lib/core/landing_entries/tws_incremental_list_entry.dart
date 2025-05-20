
import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsIncrementalListEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWS Incremental List",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "Widget that shows a generic list of items. This list has an built-in options to increment or remove items.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    List<int> list = <int>[1, 2, 3, 4];
    return TWSFLandingFrame(
      child: TWSIncrementalList<int>(
        width: 300,
        recordList: list,
        modelBuilder: () => list.length + 1,
        onRemove: () {
          print("removing last item");
          list.removeLast();
        },
        onAdd: (int model) {
          // [model] return the item to add based on model builder.
          print("adding item: $model");
          list.add(model);
        },
        recordBuilder: (int model, int index) {
          return Text("$model - index: $index");
        },
      ),
    );
  },
);
