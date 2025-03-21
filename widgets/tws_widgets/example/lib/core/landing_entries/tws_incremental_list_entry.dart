part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsIncrementalListEntry = CSMPackageLandingEntry(
  name: "TWS Incremental List",
  description: RichText(
    text: TextSpan(
      text:
          "Widget that shows a generic list of items. This list has an built-in options to increment or remove items.",
    ),
  ),
  composeLanding: (BuildContext ctx) {
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
