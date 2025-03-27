part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsDatetimePickerEntry = CSMPackageLandingEntry(
  name: "TWS Datetime Picker", 
  description: RichText(text: TextSpan(text: "shows a datepicker dialog for date and time selection."),), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSDatepicker(
        label: "label example",
        firstDate: DateTime(1999), 
        lastDate: DateTime.now()
      ), 
    );
  }
);