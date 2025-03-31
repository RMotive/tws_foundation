import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/src/core/models/tws_state_holder.dart';
import 'package:tws_widgets/src/widgets/twsf_loading_circule.dart';
import 'package:tws_widgets/tws_widgets.dart';

/// [TWSCascadeSection] Shows a custom main control widget with a colapsable content section.
class TWSCascadeSection extends StatefulWidget {
  /// Section title.
  final String title;
  /// Header top display widget.
  final Widget mainControl;
  /// Colapsable content.
  final Widget content;
  /// Trigger method on expand or colapse content.
  final FutureOr<void> Function(bool isShowing)? onPressed;
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
  late bool waiting;
  late TWSFThemeBase theme;
  late CSMColorThemeOptions colorStruct;
  late final TWSFStateHolder state;
  void stateEffect = (){};
  
  void themeUpdateListener() {
    setState(() {
      theme = getTheme();
    });
  }

  void showCascade() async {
    if(waiting) return;
    setState(() {
      waiting = true;
      show = !show;
    });
    if(widget.onPressed != null) await widget.onPressed!(show);
    waiting = false;
    state.effect();

  }

  @override
  void initState() {
    super.initState();
    waiting = false;
    state = TWSFStateHolder();
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
            child: CSMDynamicWidget<TWSFStateHolder>(
              state: state, 
              designer:(BuildContext ctx, TWSFStateHolder state) {
                stateEffect = state.effect();
                print('effect...');
                return  Visibility(
                  visible: !waiting,
                  replacement: TwsfLoadingCircle(
                    foreColor: colorStruct.hightlightAlt ?? colorStruct.highlight,
                  ),
                  child: widget.content,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
