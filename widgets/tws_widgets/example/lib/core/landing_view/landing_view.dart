import 'dart:convert';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_view/csm_view.dart';
import 'package:example/core/adapters/view_consume_adapter.dart';
import 'package:example/core/adapters/view_table_adapter.dart';
import 'package:example/core/const/image_base64.dart';
import 'package:example/core/const/mock_data.dart';
import 'package:example/core/frames/twsf_landing_frame.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_widgets/tws_widgets.dart';

part '../landing_entries/tws_button_flat_entry.dart';
part '../landing_entries/tws_section_entry.dart';
part '../landing_entries/tws_cascade_section_entry.dart';
part '../landing_entries/tws_datetime_picker_entry.dart';
part '../landing_entries/tws_confirmation_dialog_entry.dart';
part '../landing_entries/tws_display_flat_entry.dart';
part '../landing_entries/tws_dropup_entry.dart';
part '../landing_entries/tws_file_picker_entry.dart';
part '../landing_entries/tws_frame_decoration_entry.dart';
part '../landing_entries/tws_image_viewer_entry.dart';
part '../landing_entries/tws_incremental_list_entry.dart';
part '../landing_entries/tws_input_text_entry.dart';
part '../landing_entries/tws_list_tile_entry.dart';
part '../landing_entries/tws_options_selector_entry.dart';
part '../landing_entries/tws_paging_selector_entry.dart';
part '../landing_entries/tws_property_viewer_entry.dart';
part '../landing_entries/tws_section_divider_entry.dart';
part '../landing_entries/tws_selectable_list_entry.dart';
part '../landing_entries/tws_switch_button_entry.dart';
part '../landing_entries/tws_article_creation_entry.dart';
part '../landing_entries/tws_article_table_entry.dart';
part '../landing_entries/tws_autocomplete_field_entry.dart';
part '../landing_entries/tws_list_viewer_entry.dart';
part '../landing_entries/tws_photo_taker_entry.dart';

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
    double heigth = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
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
                  currentTheme = getTheme();
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: heigth - 40,
          child: 
          PackageLanding(
            name: 'tws widgets example',
            landingEntries: <PackageLandingEntryI<>>[
              _twsButtonFlatEntry,
              // _twsSectionEntry,
              _twsCascadeSectionEntry,
              // _twsDatetimePickerEntry,
              // _twsConfirmationDialogEntry,
              // _twsDisplayFlatEntry,
              _twsDropupEntry,
              // _twsFilePickerEntry,
              // _twsFrameDecorationEntry,
              // _twsFilePickerEntry,
              // _twsImageViewerEntry,
              // _twsIncrementalListEntry,
              // _twsInputTextEntry,
              // _twsListTileEntry,
              _twsOptionsSelectorEntry,
              // _twsPagingSelectorEntry,
              // _twsPropertyViewerEntry,
              // _twsSectionDividerEntry,
              _twsSelectableListEntry,
              _twsSwitchButtonEntry,
              _twsArticleCreationEntry,
              _twsArticleTable,
              // _twsAutoCompleteFieldEntry,
              // _twslistViewerEntry,
              // _twsPhotoTakerEntry,
            ],
          ),
        ),
      ],
    );
  }
}