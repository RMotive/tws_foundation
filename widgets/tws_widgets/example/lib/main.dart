import 'package:csm_view/csm_view.dart';
import 'package:example/core/tws_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:tws_widgets/tws_widgets.dart';


void main() {
  usePathUrlStrategy();  
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return CSMApplication<TWSFThemeBase>(
      listenFrame: false,
      defaultTheme: TWSFThemeLight(),
      routerConfig: TWSFRoutesTree(),
      themes: <TWSFThemeBase>[
        TWSFDarkTheme(),
        TWSFThemeLight(),
      ],
      builder: (BuildContext context, Widget? home) {
        return Title(
          title: "TWS Foundation View",
          color: Colors.black,
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 16,
            ),
            child: home ?? Container(color: Colors.red,),
          ),
        );
      },
    );
  }
}