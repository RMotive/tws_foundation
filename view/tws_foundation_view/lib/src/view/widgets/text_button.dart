import 'package:csm_view/csm_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} class.
///
/// Draws a clickable text button.
final class TextButton extends StatefulWidget {
  /// Button text displayed.
  final String text;

  /// {event} callback when button is clicked.
  final VoidCallback? onTap;

  const TextButton({
    super.key,
    this.onTap,
    required this.text,
  });

  @override
  State<TextButton> createState() => _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  /// {res} clickable text gestures recognizer to handle callbacks.
  final TapGestureRecognizer gestureRecognizer = TapGestureRecognizer()..onTap;

  /// {state} current application theme data.
  late FoundationThemeB theme = ThemingUtils.get(context);

  /// {state} whether the component is being hovered.
  bool hovered = false;

  @override
  void initState() {
    super.initState();

    gestureRecognizer.onTap = widget.onTap;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = ThemingUtils.get(context);
  }

  @override
  void dispose() {
    gestureRecognizer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PointerArea(
      onHover: (bool $in) {
        setState(() {
          hovered = $in;
        });
      },
      child: RichText(
        text: TextSpan(
          text: widget.text,
          style: TextStyle(
            fontSize: hovered ? 13 : 12,
            color: theme.page.fore,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
          ),
          recognizer: gestureRecognizer,
        ),
      ),
    );
  }
}
