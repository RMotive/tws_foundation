
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeBase> twsSwitchButtonEntry =
    PackageLandingEntry<TWSFThemeBase>(
      name: "TWS Switch Button",
      description:
          (TWSFThemeBase theme, Color foreColor) => TextSpan(
            text: "This widget returns a boolean, based on the its state.",
          ),
      contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
        return Row(
          spacing: 20,
          children: <Widget>[
            Expanded(
              child: TWSSwitchButton(
                title: "Switch example",
                onChanged: (bool p0) {
                  print(p0);
                },
              ),
            ),
            Expanded(
              child: TWSSwitchButton(
                title: "FutureOr Switch example",
                onChanged: (bool p0) async {
                  print('waiting....');
                  await Future<void>.delayed(Duration(seconds: 1));
                  print('finished: true');
                },
              ),
            ),
          ],
        );
      },
    );
