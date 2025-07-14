import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart' hide TextButton;

/// [Datepicker] shows a datepicker dialog for date and time selection.
class Datepicker extends StatefulWidget {
  /// First selectable date.
  final DateTime firstDate;
  /// Last selectable date.
  final DateTime lastDate;
  /// Text field width.
  final double width;
  /// Text field heigth.
  final double height;
  /// Text field title.
  final String? label;
  /// Text field hintext.
  final String? hintText;
  /// Optional focus node.
  final FocusNode? focusNode;
  /// Default pre-selected Date.
  final DateTime? initialDate;
  /// Optional Text controller.
  final TextEditingController? controller;
  /// Defines if the user can interact with the widget.
  final bool isEnabled;
  /// show the prefix icon or not.
  final bool enablePrefix;
  /// Callback that return the selected options in the datepicker dialog.
  final void Function(String text)? onChanged;
  /// Validator for the text input.
  final String? Function(String? text)? validator;
  /// Suffix text at the end of [label] text.
  final String? suffixLabel;
  /// Add an aditional dialog to set the time in the date picked.
  final bool addTimePicker;

  const Datepicker({super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.width = 200,
    this.height = 40,
    this.label,
    this.hintText,
    this.focusNode,
    this.enablePrefix = true,
    this.isEnabled = true,
    this.controller,
    this.onChanged,
    this.validator,
    this.suffixLabel,
    this.addTimePicker = false,
  });
  
  @override
  State<Datepicker> createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  
  String? _error;
  late final VoidCallback _ctrlListener;
  final double borderWidth = 2;
  late TextEditingController ctrl;
  late final FocusNode fNode;

  /// Theme reference key.
  final UniqueKey ref = UniqueKey();
  late SimpleTheming colorStruct;
  late SimpleTheming disabledColorStruct;
  late SimpleTheming errorColorStruct;
  late SimpleTheming pageColorStruct;

  void initializeThemes() {
    FoundationThemeB theme = Theming.get<FoundationThemeB>(context);
    colorStruct = theme.control;
    disabledColorStruct = theme.warning;
    errorColorStruct = theme.error;
    pageColorStruct = theme.page;
  }

  @override
  void initState() {
    super.initState();
    ctrl = widget.controller ??
        TextEditingController(
          text: widget.initialDate?.dateOnlyString,
        );
    fNode = widget.focusNode ?? FocusNode();
    _ctrlListener = () => setState(() {});
    ctrl.addListener(_ctrlListener);
  }
  
  @override
  void didUpdateWidget(covariant Datepicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      ctrl = widget.controller ?? TextEditingController();
    }

    ctrl.addListener(() => setState(() {}));
  }
  @override
  void didChangeDependencies() {
    initializeThemes();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ctrl.removeListener(_ctrlListener);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
        child: Material(
          color: Colors.transparent,
          child: TextFormField(
            autofocus: true,
            readOnly: true,
            validator: widget.validator,
            controller: ctrl,
            focusNode: fNode,
            enabled: widget.isEnabled,
            cursorOpacityAnimates: true,
            cursorWidth: 3,
            cursorColor: colorStruct.fore,
            onTap: () => _showDatePicker(),
            style: TextStyle(
              color: colorStruct.fore.withValues(alpha: .7),
            ),
            decoration: InputDecoration(
              isDense: true,
              errorText: _error,
              errorMaxLines: 1,
              suffixIconColor: colorStruct.back,
              hintText: widget.hintText,
              labelText: widget.suffixLabel == null? widget.label : null,
              label: widget.suffixLabel != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(widget.label ?? ""),
                        Text(
                          widget.suffixLabel!,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorStruct.fore.withValues(alpha: 50),
                          ),
                        ),
                      ],
                    )
                  : null,
              prefixIcon: (widget.enablePrefix && ctrl.text.isNotEmpty)
                  ? IconButton(
                      tooltip: "Delete selection",
                      icon: Icon(
                        Icons.cancel,
                        color: colorStruct.accent,
                        size: 20,
                      ),
                      onPressed: () {
                        // update the widget state to hide the delete button.
                        setState(() {
                          ctrl.text = '';
                          widget.onChanged?.call('');
                        });
                      },
                    )
                  : null,
              suffixIcon: const Icon(
                Icons.calendar_month,
              ),
              labelStyle: TextStyle(
                color: colorStruct.fore,
              ),
              errorStyle: TextStyle(
                color: errorColorStruct.fore,
              ),
              hintStyle: TextStyle(
                color: colorStruct.fore,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colorStruct.accent.withValues(alpha: .6),
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
      )
    );
  }
  Theme _themeDesigner(BuildContext context, Widget? child){
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.dark(
          surface: pageColorStruct.accent, //Background color
          primary: pageColorStruct.accent, // header background color
          onPrimary: pageColorStruct.fore, // header text color
          onSurface: pageColorStruct.fore // body text color
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: pageColorStruct.fore // button text color
          )
        )
      ),
      child: child!
    );
  }

  /// [_showDatePicker] Method that build the showpicker dialog.
  Future<void> _showDatePicker() async {
    /// stores the time selected when [addTimepicker] property is true.
    TimeOfDay? time;

    DateTime? date = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: widget.initialDate,
      firstDate: widget.firstDate, 
      lastDate: widget.lastDate,
      builder: (BuildContext context, Widget? child) => _themeDesigner(context, child),
    );

    if(widget.addTimePicker && mounted){
      time = await showTimePicker(
        context: context, 
        initialEntryMode: TimePickerEntryMode.inputOnly,
        initialTime: TimeOfDay.fromDateTime(widget.initialDate ?? DateTime.now()),
        builder: (BuildContext context, Widget? child) => _themeDesigner(context, child),
      );
    }
    if(date != null) {
      date = DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? date.hour,
        time?.minute ?? date.minute,
        date.second,
      );

      String? errorBuilt = widget.validator?.call(date.dateOnlyString);
      if (errorBuilt == null) {
        setState(() {
          _error = null;
          ctrl.text = time != null? date!.fullDateString : date!.dateOnlyString;
          if (widget.onChanged != null) widget.onChanged!(ctrl.text);
        });
      } else {
        setState(() {
          _error = errorBuilt;
        });
      }
    }
  }
}