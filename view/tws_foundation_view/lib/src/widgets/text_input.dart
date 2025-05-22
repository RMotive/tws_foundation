import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';

/// TWS Business dedicated component
///
/// This component builds a TWS Design opinioned component for a text input control.
///
/// TWS Theme Base, this component uses primaryControlColorStruct
final class TextInput extends StatefulWidget {
  /// Control title.
  final String? label;

  /// hint text.
  final String? hint;

  /// Control width.
  final double? width;

  /// Control height.
  final double? height;

  /// Display text on error.
  final String? errorText;

  /// Flag to add focus listener.
  final bool focusEvents;

  /// Move automaticatly the mouse pointer to this [TextInput] on load.
  final bool autofocus;

  /// Replace the characters by "*" characters to hide sensible input data.
  final bool isPrivate;

  /// Set the widget has enabled or disabled.
  final bool isEnabled;

  /// Border color on input error.
  final bool showErrorColor;

  /// Max input text lenght.
  final int? maxLength;

  /// Max input text lines.
  final int? maxLines;

  /// Don't trigger an empty error validation on empty input.
  final bool isOptional;

  /// Shows additional text at the end of the title label.
  final String? suffixLabel;

  /// Shows an icon at the end of the editable text area.
  final Widget? suffixIcon;

  /// Input text background color.
  final Color? backgroundColor;

  /// Mandatory fix input text lenght.
  ///
  /// If the input lengh is not equal to [maxLenght] value, wil trigger a input text validation error.
  final bool isStrictLength;

  /// Trigger method on tap input text.
  final void Function()? onTap;

  /// Set a custom focusNode.
  final FocusNode? focusNode;

  /// Set a custom controller.
  final TextEditingController? controller;

  /// Custom input validator method.
  final String? Function(String? text)? validator;

  /// Trigger method on input changes.
  final void Function(String text)? onChanged;

  /// Trigger method on lost focus event.
  final Function(PointerDownEvent)? onTapOutside;

  /// This values refers to the waiting time before sending an [OnChange]
  /// notification after the user has typed the last character on the input field.
  final Duration? deBounce;

  /// Set a input text formatter.
  final List<TextInputFormatter>? formatter;

  /// Set an keyboard type: Only characters, only numbers, etc...
  final TextInputType? keyboardType;

  const TextInput({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.width,
    this.validator,
    this.height,
    this.maxLength,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.suffixLabel,
    this.suffixIcon,
    this.backgroundColor,
    this.focusEvents = false,
    this.autofocus = true,
    this.isStrictLength = false,
    this.isOptional = false,
    this.showErrorColor = false,
    this.onTap,
    this.onTapOutside,
    this.deBounce,
    this.maxLines = 1,
    this.isEnabled = true,
    this.isPrivate = false,
    this.formatter,
    this.keyboardType,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final GlobalKey _inputFieldKey = GlobalKey();

  /// Theme Manager injector.
  final ThemeManagerI<FoundationThemeB> themeManager =
      Injector.getThemeManager();

  /// Theme reference key.
  final UniqueKey ref = UniqueKey();

  Timer? _deBouncer;

  final double borderWidth = 2;
  late TextEditingController ctrl;
  late final FocusNode fNode;
  late SimpleTheming colorStruct;
  late SimpleTheming disabledColorStruct;
  late SimpleTheming errorColorStruct;
  late SimpleTheming pageColorStruct;

  @override
  void initState() {
    super.initState();
    ctrl = widget.controller ?? TextEditingController();
    fNode = widget.focusNode ?? FocusNode();
    if (widget.focusEvents) setFocus();
    themeManager.addEffect(ref, themeUpdateListener);
    initializeThemes();
  }

  @override
  void didUpdateWidget(covariant TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      ctrl = widget.controller ?? TextEditingController();
    }
  }

  @override
  void dispose() {
    themeManager.removeEffect(ref);
    if (widget.focusEvents) fNode.dispose();
    _deBouncer?.cancel();
    super.dispose();
  }

  void setFocus() {
    fNode.addListener(() {
      if (fNode.hasFocus) {
        _scrollToField();
      }
    });
  }

  // Center scroll to control field
  void _scrollToField() {
    Scrollable.ensureVisible(
      _inputFieldKey.currentContext ?? context,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.2, // Aligment ratio
    );
  }

  void initializeThemes() {
    colorStruct = themeManager.get().primaryControlColor;
    disabledColorStruct = themeManager.get().primaryDisabledControl;
    errorColorStruct = themeManager.get().primaryCriticalControl;
    pageColorStruct = themeManager.get().page;
  }

  void themeUpdateListener(FoundationThemeB theme) {
    setState(() {
      initializeThemes();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showSuffix = !widget.isOptional || widget.suffixLabel == null;
    bool limitWarning =
        widget.maxLength != null && (ctrl.text.length + 5 > widget.maxLength!);
    Color counterColor =
        (!widget.isStrictLength && limitWarning)
            ? Colors.yellow
            : (!widget.isStrictLength && !limitWarning)
            ? pageColorStruct.fore.withValues(alpha: .8)
            : (ctrl.text.length < (widget.maxLength ?? 0))
            ? errorColorStruct.fore
            : Colors.green;
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextFormField(
          autofocus: widget.autofocus,
          validator: widget.validator,
          obscureText: widget.isPrivate,
          controller: ctrl,
          focusNode: fNode,
          cursorOpacityAnimates: true,
          cursorWidth: 3,
          cursorColor: colorStruct.fore,
          enabled: widget.isEnabled,
          inputFormatters: widget.formatter,
          keyboardType: widget.keyboardType,
          onTap: widget.onTap,
          onTapOutside: widget.onTapOutside,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          onChanged: (String typedText) {
            if (widget.deBounce == null) {
              widget.onChanged?.call(typedText);
              return;
            }

            if (_deBouncer?.isActive ?? false) {
              _deBouncer?.cancel();
            }

            _deBouncer = Timer(widget.deBounce!, () {
              widget.onChanged?.call(typedText);
            });
          },
          style: TextStyle(color: colorStruct.fore.withValues(alpha: .8)),
          decoration: InputDecoration(
            hintText: widget.hint,
            labelText: showSuffix ? widget.label : null,
            errorText: widget.errorText,
            isDense: true,
            suffixIcon: widget.suffixIcon,
            label:
                !showSuffix
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(widget.label ?? ""),
                        Text(
                          widget.suffixLabel!,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorStruct.fore.withValues(alpha: .5),
                          ),
                        ),
                      ],
                    )
                    : null,
            counterStyle: TextStyle(color: counterColor),
            labelStyle: TextStyle(color: colorStruct.fore),
            errorStyle: TextStyle(color: errorColorStruct.fore),
            hintStyle: TextStyle(color: colorStruct.fore),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    widget.showErrorColor
                        ? errorColorStruct.fore
                        : colorStruct.accent.withValues(alpha: .6),
                width: borderWidth,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: disabledColorStruct.accent,
                width: borderWidth,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorColorStruct.accent.withValues(alpha: .7),
                width: borderWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorColorStruct.accent,
                width: borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorStruct.accent,
                width: borderWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
