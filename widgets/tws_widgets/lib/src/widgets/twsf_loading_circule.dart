import 'package:flutter/material.dart';
/// [TwsfLoadingCircle] Display a customized loading circle.
/// 
/// Ideal for async callbacks implementations.
class TwsfLoadingCircle extends StatelessWidget {
  final Color foreColor;
  const TwsfLoadingCircle({
    super.key,
    required this.foreColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          backgroundColor: Colors.transparent,
          color: foreColor,
        ),
      ),
    );
  }
}