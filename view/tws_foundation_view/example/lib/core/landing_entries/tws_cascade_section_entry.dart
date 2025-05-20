import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsCascadeSectionEntry = PackageLandingEntry<TWSFThemeB>(
  name: "TWS Cascade Section",
  description:
      (TWSFThemeB theme, Color foreColor) => TextSpan(
        text:
            "Shows a custom main control widget with a colapsable content section.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
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
