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
  /// This method return a FutureOr widget to show when cascade is visible.
  /// This prevents unnecesary widget builds for a content that the user may not open.
  /// 
  /// [isShowing] is a cascade visibility status.
  final FutureOr<Widget> Function(bool isShowing) loadOnPress;
  /// Tool tip for colapse or expand icon.
  final String? tooltip;
  /// Section content padding.
  final EdgeInsets padding;
  /// Aligment for main controls row.
  final MainAxisAlignment mainAxisAlignment;
  /// Prevents the content to be rebuilded on press the cascade button.
  final bool preserveContent;

  const TWSCascadeSection({
    super.key,
    required this.title,
    required this.mainControl,
    required this.loadOnPress,
    this.tooltip,
    this.preserveContent = true,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.mainAxisAlignment =  MainAxisAlignment.spaceBetween,
  });

  @override
  State<TWSCascadeSection> createState() => _TWSCascadeSectionState();
}

class _TWSCascadeSectionState extends State<TWSCascadeSection> {
  /// Cascade visibility flag.
  bool show = false;
  /// Waiting status.
  late bool waiting;
  /// Color theme scheme.
  late TWSFThemeBase theme;
  late CSMColorThemeOptions colorStruct;
  /// Content internal state manager.
  late final TWSFStateHolder state;
  void stateEffect = (){};
  /// Widget cascade content;
  late Widget content;
  
  void themeUpdateListener() {
    setState(() {
      theme = getTheme();
    });
  }

  void showCascade() async {
    if(waiting) return;
    waiting = true;
    setState(() {
      show = !show;
    });
    /// Validate if the widget builder was trigger.
    if(!widget.preserveContent || content.runtimeType == Placeholder){
      content = await widget.loadOnPress(show);
    }else{
      /// Use the current cascade content and execute the loadOnPress method, skipping rebuilding of the content.
      await widget.loadOnPress(show);
    }
    waiting = false;
    state.effect();

  }

  @override
  void initState() {
    super.initState();
    waiting = false;
    content = Placeholder();
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
                  child: content,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
