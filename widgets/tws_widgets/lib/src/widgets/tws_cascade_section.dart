import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

/// [TWSCascadeSection] Widget shows a custom main control widget with a colapsable content section.
class TWSCascadeSection extends StatefulWidget {
  /// Section title.
  final String title;
  /// Header top display widget.
  final Widget mainControl;
  /// Colapsable content.
  final Widget content;
  /// Trigger method on expand or colapse content.
  final void Function(bool isShowing)? onPressed;
  /// Tool tip for colapse or expand icon.
  final String? tooltip;
  /// Section content padding.
  final EdgeInsets padding;
  /// Aligment for main controls row.
  final MainAxisAlignment mainAxisAlignment;

  const TWSCascadeSection({
    super.key,
    required this.title,
    required this.mainControl,
    required this.content,
    this.onPressed,
    this.tooltip,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.mainAxisAlignment =  MainAxisAlignment.spaceBetween,
  });

  @override
  State<TWSCascadeSection> createState() => _TWSCascadeSectionState();
}

class _TWSCascadeSectionState extends State<TWSCascadeSection> {
  bool show = false;
  late TWSFThemeBase theme;
  late CSMColorThemeOptions colorStruct;
  
  void themeUpdateListener() {
    setState(() {
      theme = getTheme();
    });
  }

  void showCascade(){
    setState(() {
      if(widget.onPressed != null) widget.onPressed!(show);
      show = !show;
    });
  }

  @override
  void initState() {
    super.initState();
    theme = getTheme(
      updateEfect: themeUpdateListener,
    );
    colorStruct = theme.primaryControlColor;
  }

  @override
  void didUpdateWidget (TWSCascadeSection oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    disposeEffect(themeUpdateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return TWSSection(
      padding: widget.padding,
      title: widget.title,
      content: CSMSpacingColumn(
        spacing: 10,
        children: <Widget>[
          CSMSpacingRow(
            spacing: 10,
            mainAlignment: widget.mainAxisAlignment,
            children: <Widget>[
              widget.mainControl,
              IconButton(
                hoverColor: colorStruct.fore,
                isSelected: show,
                selectedIcon: const Icon(Icons.remove),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    colorStruct.hightlightAlt ?? colorStruct.highlight,
                  ),
                ),
                padding: EdgeInsets.zero,
                tooltip: widget.tooltip,
                color: Colors.white,
                iconSize: 32,
                onPressed: showCascade,
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
          Visibility(
            visible: show,
            child: widget.content,
          ),
        ],
      ),
    );
  }
}
