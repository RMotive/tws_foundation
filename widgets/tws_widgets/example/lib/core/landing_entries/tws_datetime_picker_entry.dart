part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsDatetimePickerEntry = CSMPackageLandingEntry(
  name: "TWS Datetime Picker", 
  description: RichText(text: TextSpan(text: "Custom TWS Datetime Picker component"),), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSDatepicker<TWSFThemeBase>(
        label: "label example",
        firstDate: DateTime(1999), 
        lastDate: DateTime.now()
      ), 
    );
  }
);