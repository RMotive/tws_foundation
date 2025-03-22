import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

/// [TWSSwitchButton] Custom widget for TWS environment.
/// This widget returns a boolean, based on the its state.
class TWSSwitchButton extends StatefulWidget {
  /// switch button heigth
  final double height;

  /// switch state.
  final bool value;

  /// Text to show on top of the component.
  final String title;

  /// Internal Padding value.
  final EdgeInsetsGeometry padding;

  /// Callback for switch state, returning the state value.
  final void Function(bool) onChanged;

  const TWSSwitchButton({
    super.key,
    required this.title,
    required this.onChanged,
    this.height = 35,
    this.value = false,
    this.padding = const EdgeInsets.all(5.0),
  });

  @override
  State<TWSSwitchButton> createState() => _TWSSwitchButtonState();
}

class _TWSSwitchButtonState extends State<TWSSwitchButton> {
  late TWSFThemeBase theme;
  late CSMColorThemeOptions colorStruct;
  bool _value = false;

  @override
  void initState() {
    _value = widget.value;
    theme = getTheme(
      updateEfect: themeUpdateListener,
    );
    colorStruct = theme.primaryControlColor;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    disposeEffect(themeUpdateListener);
  }

  void themeUpdateListener() {
    setState(() {
      theme = getTheme();
      colorStruct = theme.primaryControlColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              color: colorStruct.fore,
            ),
          ),
          SizedBox(
            height: widget.height,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Material(
                color: Colors.transparent,
                child: Switch(
                  value: _value,
                  activeColor: colorStruct.foreAlt,
                  activeTrackColor: colorStruct.main,
                  onChanged: (bool change) {
                    setState(() {
                      _value = change;
                      widget.onChanged(change);
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
