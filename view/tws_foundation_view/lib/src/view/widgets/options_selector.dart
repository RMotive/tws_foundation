import 'dart:async';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {constant} defines the minimum width for the each options.
const double _minOptionWidth = 75;

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

  /// SVG resorce icon RouteData.
  final String? resource;

  /// Icon rotation ratio: 1 = 90º, 2 = 180º, etc.
  final int iconRotation;

  /// Icon color to apply.
  final Color? iconColor;

  /// Creates a new [OptionsSelectorOption] instance.
  const OptionsSelectorOption({
    required this.title,
    required this.value,
    this.iconRotation = 0,
    this.resource,
    this.iconColor,
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

  /// Values pre-selected, search the matching options values and set has selected items.
  final List<TValue>? preSelected;

  /// Whether the [Widget] is enabled.
  final bool isEnabled;

  /// Fixed optios height.
  final double? height;

  /// Horizontal spacing between items.
  final double hSpacing;

  /// Label text size.
  final double fontSize;

  /// Selector title.
  final String title;

  /// Whether the selection is optional, when it is and no selection, the [onSelect] callback will send and empty [List]<[TValue]>.
  final bool optional;

  /// Creates a new [OptionsSelector] instance.
  const OptionsSelector({
    super.key,
    this.height,
    this.fontSize = 16,
    this.preSelected,
    this.optional = false,
    this.isEnabled = true,
    this.multiSelection = false,
    this.hSpacing = _kDefItemSpacing,
    required this.title,
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

  /// {state} current application theme data.
  late FoundationThemeB theme = ThemingUtils.get(context);

  @override
  void didUpdateWidget(covariant OptionsSelector<TValue> oldWidget) {
    if (oldWidget.preSelected != widget.preSelected) {
      selection = widget.preSelected ?? <TValue>[];
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = ThemingUtils.get(context);
  }

  /// {event} triggered when the option items selection changes.
  ///
  /// [selValue] trigger selected value.
  void onSelectionChange(TValue selValue) {
    if (!widget.multiSelection) {
      if (selection.isEmpty) {
        setState(() {
          selection.add(selValue);
          widget.onSelect(selection);
        });
        return;
      }

      if (selection.contains(selValue)) {
        return;
      }

      setState(() {
        selection = <TValue>[selValue];
        widget.onSelect(selection);
      });
      return;
    }

    setState(() {
      if (selection.contains(selValue)) {
        selection.remove(selValue);
      } else {
        selection.add(selValue);
      }
      widget.onSelect(selection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<TValue>>(
      initialValue: selection,
      validator: (List<TValue>? value) {
        if ((value == null || value.isEmpty) && !widget.optional) {
          return 'Must select an option';
        }
        return null;
      },
      builder: (FormFieldState<List<TValue>> fieldState) {
        return SectionWidget(
          title: '${widget.optional ? '' : '*'}${widget.title}',
          borderColor: fieldState.hasError ? theme.controlError.accent : null,
          outterPadding: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              left: 8,
              right: 8,
              bottom: 8,
            ),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// --> Error message
                if (fieldState.hasError)
                  Text(
                    fieldState.errorText ?? '---',
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.controlError.fore,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                /// --> Options box
                LayoutBuilder(
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
                                  resource: option.resource,
                                  iconColor: option.iconColor,
                                  iconRotation: option.iconRotation,
                                  onSelect: () {
                                    fieldState.reset();
                                    onSelectionChange(option.value);
                                    fieldState.didChange(selection);
                                  },
                                  selected: selection.contains(option.value),
                                );
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
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

  /// SVG resource icon RouteData.
  final String? resource;

  /// Color to apply to the icon.
  final Color? iconColor;

  /// Icon rotation ratio: 1 = 90º, 2 = 180º, etc.
  final int iconRotation;

  /// {event} callback when item is selected.
  final void Function() onSelect;

  /// Creates a new [_OptionsSelectorItem] instance.
  const _OptionsSelectorItem({
    this.height,
    this.fontSize = 16,
    this.selected = false,
    this.iconRotation = 0,
    this.resource,
    this.iconColor,
    required this.label,
    required this.width,
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
  late FoundationThemeB theme = ThemingUtils.get<FoundationThemeB>(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = ThemingUtils.get<FoundationThemeB>(context);
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
                ? theme.page.accent
                : hovered
                ? theme.page.accent.withValues(
                  alpha: .3,
                )
                : theme.page.back,
        child: BorderedBox(
          color: theme.page.accent,
          padding: EdgeInsets.all(_kItemsPadding),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: widget.resource != null? 
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RotatedBox(
                      quarterTurns: widget.iconRotation,
                      child: SvgPicture.asset(
                        widget.resource!,
                        height: widget.height,
                        colorFilter: ColorFilter.mode(
                                  widget.selected
                                      ? widget.iconColor ?? theme.page.foreAlt ?? theme.page.fore
                                      : widget.iconColor ?? theme.page.fore,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.w500,
                      color: widget.selected ? theme.page.foreAlt : theme.page.fore,
                    ),
                  ),
                ],
              ),
            )
            : Center(
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w500,
                  color: widget.selected ? theme.page.foreAlt : theme.page.fore,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
