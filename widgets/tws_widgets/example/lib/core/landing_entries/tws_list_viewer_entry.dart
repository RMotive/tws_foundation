import 'package:csm_view/csm_view.dart';
import 'package:example/core/const/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_widgets/tws_widgets.dart';

PackageLandingEntry<TWSFThemeBase> twslistViewerEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS List Viewer", 
  description:
          (TWSFThemeBase theme, Color foreColor) => TextSpan(
            text: "A simple list component to show a section that contains a list with a title and subtitle.",
          ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    final AsyncWidgetController consumerAgent = AsyncWidgetController(); 
      Future<ViewOutput<TrailerClass>> data() async {
        await Future<void>.delayed(Duration(seconds: 2));
        ViewOutput<TrailerClass> view = ViewOutput<TrailerClass>(() => TrailerClass());
        view.entities = mockTrailerClasses;
        return view;
      }

    return Row(
        spacing: 10,
        children: <Widget>[
          Expanded(
            child: TwsListViewer<TrailerClass>(
              title: "Features async data", 
              agent: consumerAgent ,
              consume:() => data(),
              tileTitle:(TrailerClass set) {
                return set.name;
              },
            ),
          ),
          Expanded(
            child: TwsListViewer<TrailerClass>(
              title: "Features native data", 
              tilesContent: mockTrailerClasses,
              tileTitle:(TrailerClass set) {
                return set.name;
              },
            ),
          ),
        ],
      );
  }
);