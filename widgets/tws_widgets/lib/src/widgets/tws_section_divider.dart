import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

/// [TWSSectionDivider] a custom divider component to divide the sections or sub-sections.
/// This component shows horizontal line with a centered section name, ideal for dividing sections in a column.
class TWSSectionDivider extends StatelessWidget {
  /// Divider color.
  final Color? color;
  
  /// Centered text title.
  final String text;
  
  const TWSSectionDivider({
    super.key,
    this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color? mainColor = color; 
    if(color == null){
    final ThemeManagerI<TWSFThemeBase> themeManager = Injector.getThemeManager();
      mainColor = themeManager.get().page.fore;
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: mainColor,
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.italic,
                color: mainColor
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: mainColor,
            )
          )
        ],
      ),
    );
  }
}