import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeBase>
twsFilePickerEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS File Picker",
  description:
      (TWSFThemeBase theme, Color foreColor) => TextSpan(
        text:
            "Widget that shows a dialog (web or mobile) to select one or multiple specified extension files.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    return TWSFLandingFrame(
      width: 500,
      child: TwsFilePicker(
        dialogTitle: "File Picker example",
        onSelect: (List<XFile> xFiles, List<PlatformFile> files) {
          print("Selected image: ${files.first.name}");
        },
      ),
    );
  },
);
