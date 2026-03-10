import 'package:csm_view/csm_view.dart';
import 'package:example/themes/landing_theme_b.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart' show SessionData;
import 'package:tws_foundation_view/tws_foundation_view.dart' as view;

///
final class AuthPageEntry extends PackageLandingEntryBase<LandingThemeB> {
  ///
  AuthPageEntry({super.key})
    : super(
        name: 'Auth Page',
        image: AssetImage(view.FoundationAssets.businessIcon),
        description: (LandingThemeB theme, Color foreColor) {
          return TextSpan(
            text:
                'Page to authenticate users along all TWS Solutions by the configured authentication options. To use this playground entry succesfuly you must have your local server running in background at default development configruations and automatically will call it',
            style: TextStyle(fontSize: 14, color: foreColor)
          );
        },
      );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, LandingThemeB theme) {
    return view.AuthPage(
      solutionSign: 'TWSMF',
      onAuthSuccess: (SessionData serverSession) {
        showDialog(
          context: buildContext,
          builder: (BuildContext context) {
            return DefaultTextStyle(
              style: TextStyle(color: theme.page.fore),
              child: AlertDialog(
                backgroundColor: theme.page.back,
                title: Text("Congrats!"),
                content: Text(
                  "Your credentials were succesfuly authenticated at your local server!!!",
                  style: TextStyle(color: theme.page.fore),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                    child: Text("Great!"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
