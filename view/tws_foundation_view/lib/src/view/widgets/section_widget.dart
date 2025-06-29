import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/core/themes/foundation_theme_b.dart';

/// {widget} class.
///
/// Draws a {csm} design {widget} to handle section separator along pages.
final class SectionWidget extends StatelessWidget {
  /// Displayed title of the section.
  final String title;

  /// Section content to render.
  final Widget child;

  /// Padding calculated from the parent widget.
  final EdgeInsets outterPadding;

  /// Whether this section is optional.
  final bool isOptional;

  /// Overrides the built-in border color.
  final Color? borderColor;

  /// Title text style.
  final TextStyle? textStyle;

  /// Creates a new [SectionWidget] instance.
  const SectionWidget({
    super.key,
    this.isOptional = false,
    this.outterPadding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 20,
    ),
    this.borderColor,
    this.textStyle,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final SimpleTheming pageTheming = Theming.get<FoundationThemeB>(context).page;

    final Color bColor =
        isOptional
            ? pageTheming.fore.withValues(
              alpha: .5,
            )
            : borderColor ?? pageTheming.accent;

    return Padding(
      padding: outterPadding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              width: 2,
              color: bColor,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Transform.translate(
                  offset: const Offset(
                    0,
                    -40,
                  ),
                  child: ColoredBox(
                    color: pageTheming.back,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style:
                            textStyle ??
                            TextStyle(
                              color: pageTheming.fore,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
