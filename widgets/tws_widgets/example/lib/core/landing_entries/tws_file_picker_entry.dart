part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsFilePickerEntry = CSMPackageLandingEntry(
  name: "TWS File Picker", 
  description: RichText(text: TextSpan(text: "Custom TWS File Picker component"),), 
  composeLanding: (BuildContext ctx) {
    return Column(
      children: <Widget>[
        TwsFilePicker(
          dialogTitle: "File Picker example", 
          onSelect:(List<XFile> xFiles, List<PlatformFile> files) {
            print("Selected image: ${files.first.name}");
          },
        )
      ],
    );
  }
);