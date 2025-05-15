
import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

PackageLandingEntry<TWSFThemeBase> twsDatetimePickerEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS Datetime Picker", 
  description:
          (TWSFThemeBase theme, Color foreColor) => TextSpan(
            text: "shows a datepicker dialog for date and time selection.",
          ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    return TWSFLandingFrame(
      child: TWSDatepicker(
          label: "label example",
          firstDate: DateTime(1999), 
          lastDate: DateTime.now(),
          onChanged: (String text) {
            print('selected date: $text');
          },
        ),
    );
  }
);