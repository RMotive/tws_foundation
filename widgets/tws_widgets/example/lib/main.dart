import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late TWSFThemeBase currentTheme;

  @override
  void initState() {
    currentTheme = TWSFDarkTheme();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: <Widget>[
            CSMSpacingRow(
              spacing: 16,
              children: <Widget>[
                Expanded(
                  child: TWSButtonFlat<TWSFThemeBase>(
                    label: "refresh",
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: TWSButtonFlat<TWSFThemeBase>(
                    label: "Change theme",
                    theme: currentTheme,
                    onTap: () {
                      setState(() {
                        if(currentTheme.identifier == "foundation-dark-flat-theme"){
                          currentTheme = TWSFThemeLight();
                        }else{
                          currentTheme = TWSFDarkTheme();
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: CSMPackageLanding(
                title: 'tws widgets example',
                entries: <CSMPackageLandingEntry>[
                  CSMPackageLandingEntry(
                    name: "TWSButtonFlat", 
                    description: RichText(
                      text: TextSpan(
                        text:
                            "Simple stylish button. \nThis component has the same color scheme in dark and light themes.",
                      ),
                    ), 
                    composeLanding: (BuildContext ctx) {
                      return TWSButtonFlat<TWSFThemeBase>(
                        theme: currentTheme,
                        onTap: () => print("TWSButtonFlat: Tap..."),
                      );
                    }
                  ),
                  CSMPackageLandingEntry(
                    name: "TWS Section", 
                    description: RichText(text: TextSpan(text: "Custom TWS section component"),), 
                    composeLanding: (BuildContext ctx) {
                      return TWSSection<TWSFThemeBase>(
                        theme: currentTheme, 
                        title: "Section Example", 
                        content: Container(),
                      );
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}