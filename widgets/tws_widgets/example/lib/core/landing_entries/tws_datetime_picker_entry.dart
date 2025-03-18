part of '../landing_view.dart';

CSMPackageLandingEntry _tws_datetime_picker_entry = CSMPackageLandingEntry(
  name: "TWS Datetime Picker", 
  description: RichText(text: TextSpan(text: "Custom TWS Datetime Picker component"),), 
  composeLanding: (BuildContext ctx) {
    return Column(
      children: <Widget>[
        Center(
          child: TWSDatepicker<TWSFThemeBase>(
            firstDate: DateTime(1999), 
            lastDate: DateTime.now()
          ),
        )
      ],
    );
  }
);