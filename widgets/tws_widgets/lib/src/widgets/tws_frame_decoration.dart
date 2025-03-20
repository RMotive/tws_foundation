import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

final class TWSFrameDecoration extends StatelessWidget {
  final Widget child;
  final double topPadding;
  const TWSFrameDecoration({
    super.key,
    this.topPadding = 8,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              color: getTheme<TWSFThemeBase>().page.fore,
              width: 2,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
