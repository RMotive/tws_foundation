import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/src/widgets/twsf_loading_circule.dart';
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
  final FutureOr<void> Function(bool) onChanged;

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
  /// Theme Manager injector.
  final ThemeManagerI<TWSFThemeBase> themeManager = Injector.get();

  /// Theme reference key.
  final UniqueKey ref = UniqueKey();

  /// Color pallet for the component.
  late SimpleTheming primaryColorTheme;

  bool _value = false;

  /// Waiting status
  late bool waiting;

  @override
  void initState() {
    _value = widget.value;
    waiting = false;
    themeManager.addEffect(ref, themeUpdateListener);
    primaryColorTheme = themeManager.get().primaryControlColor;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    themeManager.removeEffect(ref);
  }

  void themeUpdateListener(TWSFThemeBase theme) {
    setState(() {
      primaryColorTheme = theme.primaryControlColor;
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
              color: primaryColorTheme.fore,
            ),
          ),
          Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: widget.height,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Material(
                    color: Colors.transparent,
                    child: Switch(
                      value: _value,
                      activeColor: primaryColorTheme.foreAlt,
                      activeTrackColor: primaryColorTheme.back,
                      onChanged: (bool change) async {
                        if(waiting) return;
                        setState(() {
                          waiting = true;
                          _value = change;
                        });
                        await widget.onChanged(change);
                        setState(() => waiting = false);
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: waiting,
                child: TwsfLoadingCircle(
                  padding: EdgeInsets.zero,
                  foreColor: primaryColorTheme.accent
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
