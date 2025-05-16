import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

PackageLandingEntry<TWSFThemeBase>
twsCascadeSectionEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS Cascade Section",
  description:
      (TWSFThemeBase theme, Color foreColor) => TextSpan(
        text:
            "Shows a custom main control widget with a colapsable content section.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    return TWSFLandingFrame(
      child: Row(
        spacing: 20,
        children: <Widget>[
          Expanded(
            child: TWSCascadeSection(
              title: "Cascade Example",
              mainControl: Container(
                color: Colors.green,
                child: Text("Main control section"),
              ),
              loadOnPress: (bool isShowing) {
                return Container(height: 300, color: Colors.red);
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
              loadOnPress: (bool isShowing) async {
                if (isShowing) {
                  await Future<void>.delayed(Duration(seconds: 1));
                  print('loaded....');
                }
      
                return Container(height: 300, color: Colors.red);
              },
            ),
          ),
        ],
      ),
    );
  },
);
