import 'package:flutter/material.dart';

/// [TWSFLandingFrame] widget to wrap content for a proper layout handling in a [CSMPackageLanding] component.
class TWSFLandingFrame extends StatelessWidget {
  /// Content to wrap.
  final Widget child;
  /// Default padding value.
  final EdgeInsets padding;
  /// Content width.
  final double? width;
  /// Content height.
  final double? height;
  const TWSFLandingFrame({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        )
      ],
    );
  }
}