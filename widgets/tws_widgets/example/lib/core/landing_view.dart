import 'dart:convert';

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_view/csm_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

part 'landing_entries/tws_button_flat_entry.dart';
part 'landing_entries/tws_section_entry.dart';
part 'landing_entries/tws_cascade_section_entry.dart';
part 'landing_entries/tws_datetime_picker_entry.dart';
part 'landing_entries/tws_confirmation_dialog_entry.dart';
part 'landing_entries/tws_display_flat_entry.dart';
part 'landing_entries/tws_dropup_entry.dart';
part 'landing_entries/tws_file_picker_entry.dart';
part 'landing_entries/tws_frame_decoration_entry.dart';
part 'landing_entries/tws_image_viewer_entry.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  late TWSFThemeBase currentTheme;
  
  void themeUpdateListener() {
    setState(() {
      currentTheme = getTheme();
    });
  }

  @override
  void initState() {
    currentTheme = getTheme(
      updateEfect: themeUpdateListener,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CSMSpacingRow(
          spacing: 16,
          children: <Widget>[
            Expanded(
              child: TWSButtonFlat(
                label: "refresh",
                onTap: () {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: TWSButtonFlat(
                label: "Change theme\nCurrent theme: ${currentTheme.identifier}",
                onTap: () {
                  if(currentTheme.identifier == TWSFDarkTheme.kIdentifier){
                    updateTheme(TWSFThemeLight.kIdentifier);
                  }else{
                    updateTheme(TWSFDarkTheme.kIdentifier);
                  }
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: CSMPackageLanding(
            title: 'tws widgets example',
            entries: <CSMPackageLandingEntry>[
              _twsButtonFlatEntry,
              _twsSectionEntry,
              _twsCascadeSectionEntry,
              _twsDatetimePickerEntry,
              _twsConfirmationDialogEntry,
              _twsDisplayFlatEntry,
              _twsDropupEntry,
              _twsFilePickerEntry,
              _twsFrameDecorationEntry,
              _twsFilePickerEntry,
              _twsImageViewerEntry,
            ],
          ),
        ),
      ],
    );
  }
}