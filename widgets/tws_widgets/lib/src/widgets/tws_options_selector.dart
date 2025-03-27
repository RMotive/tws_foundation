import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

/// [TwsOptionsSelector] widget that display a [Wrap] that contains a list of selectable actions given in [options] property.
class TwsOptionsSelector<T> extends StatefulWidget {
  /// Actions list to display in this widget.
  final List<TwsOptionSelectorAction<T>> options;

  /// Trigger function on action selection.
  final Function(T value) onSelect;

  /// Preselected action.
  final T? initialValue;
  
  /// Widget status flag.
  final bool enabled;

  const TwsOptionsSelector({ super.key,
    required this.options,
    required this.onSelect,
    this.initialValue,
    this.enabled = true,
  });

  @override
  State<TwsOptionsSelector<T>> createState() => _TwsOptionsSelectorState<T>();
}

class _TwsOptionsSelectorState<T> extends State<TwsOptionsSelector<T>> {
  /// Internal selected option.
  late T? selected;

  @override
  void initState() {
    selected = widget.initialValue ?? widget.options.first.value;
    super.initState();
  }
  @override
  void didUpdateWidget(covariant TwsOptionsSelector<T> oldWidget) {
    if(selected != widget.initialValue){
      selected = widget.initialValue ?? selected;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double spacing = 10;
        return Center(
          child: Wrap(
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: <Builder>[
              for (int i = 0; i < widget.options.length; i++)
                Builder(
                  builder:(BuildContext context) {
                    double maxWidth = widget.options[i].maxWidth - spacing/2;
                    double minwidth =
                        widget.options[i].minWidth > widget.options[i].maxWidth
                            ? maxWidth
                            : widget.options[i].minWidth - spacing/2;
                    return  ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: minwidth,
                        maxWidth: maxWidth,
                      ),
                      child: TWSButtonFlat(
                        label: widget.options[i].title,
                        disabled: widget.initialValue != null
                            ? widget.options[i].value == selected
                            : (widget.options[i].value == selected) || (!widget.enabled),
                        onTap: () {
                          setState(() {
                            if(!widget.enabled) return;
                            selected = widget.options[i].value;
                            widget.onSelect(widget.options[i].value);
                          });
                        },
                      ),
                    );
                  },
                ),
                
            ],
          ),
        );
      },
    );
  }
}
