import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';
/// TWS Business component.
///
/// Defined to handle section separator along pages sections.
/// Theme Struct:
///   - required[pageColorStruct]
///   - optional[twsSectionStruct]
class TWSSection extends StatelessWidget {
  /// Indicates the display title to show in the section.
  final String title;

  /// The content to be rendered in the section.
  final Widget content;

  /// The padding that the border decorator will use
  final EdgeInsets padding;

  final bool isOptional;

  //Section custom color border.
  final Color? borderColor;

  // Section title textStyle.
  final TextStyle? textStyle;

  /// Renders a page section.
  ///
  /// Theme Struct:
  ///   - required[pageColorStruct]
  ///   - optional[twsSectionStruct]
  const TWSSection({
    super.key,
    this.isOptional = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 20,
    ),
    this.borderColor,
    this.textStyle,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManager<TWSFThemeBase> themeManager = Injector.get();
    final SimpleTheming pageTheme = themeManager.get().page;
    final Color bColor = isOptional ? pageTheme.fore.withValues(alpha: .5) : borderColor ?? pageTheme.accent;
    return Padding(
      padding: padding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              width: 2, 
              color: bColor,
              strokeAlign: BorderSide.strokeAlignCenter
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
                  offset: const Offset(0, -35),
                  child: ColoredBox(
                    color: pageTheme.back,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        title,
                        style: textStyle ??
                        TextStyle(
                          color: pageTheme.fore,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
