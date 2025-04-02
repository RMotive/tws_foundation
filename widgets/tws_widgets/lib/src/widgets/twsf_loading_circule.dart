import 'package:flutter/material.dart';
/// [TwsfLoadingCircle] Display a customized loading circle.
/// 
/// Ideal for async callbacks implementations.
class TwsfLoadingCircle extends StatelessWidget {
  /// Circule color.
  final Color foreColor;
  /// Boxfit behavior.
  final BoxFit fit;
  /// Padding.
  final EdgeInsets padding;
  const TwsfLoadingCircle({
    super.key,
    required this.foreColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 8,
    ),
    this.fit = BoxFit.fitHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: FittedBox(
        fit: fit,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          backgroundColor: Colors.transparent,
          color: foreColor,
        ),
      ),
    );
  }
}