import 'dart:async';

import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/view/widgets/bordered_box.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {constant} defines the minimum width for the each options.
const double _minOptionWidth = 125;

/// {constant} stores the default spacing between items at the options selector inner [Wrap].
const double _kDefItemSpacing = 10;

/// {constant} stores the default inner padding for each item option.
const double _kItemsPadding = 12;

/// {model} class.
///
///
/// [TValue] type of the value to be handled.
///
///
/// Data model class that stores a selectable value option for [OptionsSelector].
final class OptionsSelectorOption<TValue> {
  /// Option title.
  final String title;

  /// Option value.
  final TValue value;

  /// Creates a new [OptionsSelectorOption] instance.
  const OptionsSelectorOption({
    required this.title,
    required this.value,
  });
}

/// {widget} class.
///
///
/// [TValue] type of the value to be handled.
///
///
/// Draws a complex [Widget] that handles several options selection.
final class OptionsSelector<TValue> extends StatefulWidget {
  /// Options.
  final List<OptionsSelectorOption<TValue>> options;

  /// Whether more than one option selection is enabled.
  final bool multiSelection;

  /// {event} when any option is selected this callback is triggered, when [multiSelection] is enabled a collection of values with the current
  /// selection options stack is given, when it is disabled the collection will only contain the only selected option.
  final FutureOr<void> Function(List<TValue> selected) onSelect;

  /// Values pre-selected.
  final List<TValue>? preSelected;

  /// Whether the [Widget] is enabled.
  final bool isEnabled;

  /// Fixed optios height.
  final double? height;

  /// Horizontal spacing between items.
  final double hSpacing;

  /// Label text size.
  final double fontSize;

  /// Creates a new [OptionsSelector] instance.
  const OptionsSelector({
    super.key,
    this.height,
    this.fontSize = 16,
    this.preSelected,
    this.isEnabled = true,
    this.multiSelection = false,
    this.hSpacing = _kDefItemSpacing,
    required this.options,
    required this.onSelect,
  });

  @override
  State<OptionsSelector<TValue>> createState() => _OptionsSelectorState<TValue>();
}

/// {state} class.
///
///
/// [TValue] type of the value to be handled.
///
///
/// Handles [State] for [OptionsSelector].
final class _OptionsSelectorState<TValue> extends State<OptionsSelector<TValue>> {
  /// {state} current selected options.
  late List<TValue> selection = widget.preSelected ?? <TValue>[];

  @override
  void didUpdateWidget(covariant OptionsSelector<TValue> oldWidget) {
    if (oldWidget.preSelected != widget.preSelected) {
      selection = widget.preSelected ?? <TValue>[];
    }

    super.didUpdateWidget(oldWidget);
  }

  /// {event} triggered when the option items selection changes.
  ///
  /// [selValue] trigger selected value.
  void onSelectionChange(TValue selValue) {
    if (!widget.multiSelection) {
      if (selection.isEmpty) {
        setState(() {
          selection.add(selValue);
        });
        return;
      }

      if (selection.contains(selValue)) {
        return;
      }

      setState(() {
        selection = <TValue>[selValue];
      });
      return;
    }

    setState(() {
      if (selection.contains(selValue)) {
        selection.remove(selValue);
      } else {
        selection.add(selValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext layoutBuildContext, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.boxed();

        double boxSpacing = (boxConstraints.maxWidth) - (widget.hSpacing * (widget.options.length - 1));

        double optionWidth = (boxSpacing / widget.options.length) - (_kItemsPadding * 2);

        if (optionWidth < _minOptionWidth) {
          optionWidth = _minOptionWidth;
        }

        
        return SizedBox(
          width: boxConstraints.maxWidth,
          child: Wrap(
            spacing: widget.hSpacing,
            runSpacing: _kDefItemSpacing,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Builder>[
              for (int i = 0; i < widget.options.length; i++)
                Builder(
                  builder: (BuildContext context) {
                    OptionsSelectorOption<TValue> option = widget.options[i];

                    return _OptionsSelectorItem(
                      width: optionWidth,
                      label: option.title,
                      height: widget.height,
                      fontSize: widget.fontSize,
                      onSelect: () => onSelectionChange(option.value),
                      selected: selection.contains(option.value),
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

/// {private} {widget} class.
///
/// Draws an item element [Widget] for [OptionsSelector] handling specific behvaior for option item context.
final class _OptionsSelectorItem extends StatefulWidget {
  /// [Widget] width size.
  final double width;

  /// [Widget] height size.
  final double? height;

  /// Label font size.
  final double fontSize;

  /// Descriptive option label.
  final String label;

  /// Whether the current item is selected.
  final bool selected;

  /// {event} callback when item is selected.
  final void Function() onSelect;

  /// Creates a new [_OptionsSelectorItem] instance.
  const _OptionsSelectorItem({
    this.height,
    this.fontSize = 16,
    required this.label,
    required this.width,
    this.selected = false,
    required this.onSelect,
  });

  @override
  State<_OptionsSelectorItem> createState() => _OptionsSelectorItemState();
}

/// {state} class.
///
/// Handles [State] for [_OptionsSelectorItem].
final class _OptionsSelectorItemState extends State<_OptionsSelectorItem> {
  /// {state} whether the current [Widget] is being hovered.
  bool hovered = false;

  /// {state} current theme data.
  late FoundationThemeB fountTheming = Theming.get<FoundationThemeB>(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    fountTheming = Theming.get<FoundationThemeB>(context);
  }

  @override
  Widget build(BuildContext context) {
    return PointerArea(
      cursor: SystemMouseCursors.click,
      onClick: widget.onSelect,
      onHover: (bool $in) {
        setState(() {
          hovered = $in;
        });
      },
      child: ColoredBox(
        color:
            widget.selected
                ? fountTheming.page.accent
                : hovered
                ? fountTheming.page.accent.withValues(
                  alpha: .3,
                )
                : fountTheming.page.back,
        child: BorderedBox(
          color: fountTheming.page.accent,
          padding: EdgeInsets.all(_kItemsPadding),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Center(
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w500,
                  color: widget.selected ? fountTheming.page.foreAlt : fountTheming.page.fore,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
