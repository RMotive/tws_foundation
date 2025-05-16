import 'package:csm_view/csm_view.dart';
import 'package:example/core/landing_entries/tws_article_creation_entry.dart';
import 'package:example/core/landing_entries/tws_article_table_entry.dart';
import 'package:example/core/landing_entries/tws_autocomplete_field_entry.dart';
import 'package:example/core/landing_entries/tws_button_flat_entry.dart';
import 'package:example/core/landing_entries/tws_cascade_section_entry.dart';
import 'package:example/core/landing_entries/tws_confirmation_dialog_entry.dart';
import 'package:example/core/landing_entries/tws_datetime_picker_entry.dart';
import 'package:example/core/landing_entries/tws_display_flat_entry.dart';
import 'package:example/core/landing_entries/tws_dropup_entry.dart';
import 'package:example/core/landing_entries/tws_file_picker_entry.dart';
import 'package:example/core/landing_entries/tws_frame_decoration_entry.dart';
import 'package:example/core/landing_entries/tws_image_viewer_entry.dart';
import 'package:example/core/landing_entries/tws_incremental_list_entry.dart';
import 'package:example/core/landing_entries/tws_input_text_entry.dart';
import 'package:example/core/landing_entries/tws_list_tile_entry.dart';
import 'package:example/core/landing_entries/tws_list_viewer_entry.dart';
import 'package:example/core/landing_entries/tws_options_selector_entry.dart';
import 'package:example/core/landing_entries/tws_paging_selector_entry.dart';
import 'package:example/core/landing_entries/tws_photo_taker_entry.dart';
import 'package:example/core/landing_entries/tws_section_divider_entry.dart';
import 'package:example/core/landing_entries/tws_section_entry.dart';
import 'package:example/core/landing_entries/tws_selectable_list_entry.dart';
import 'package:example/core/landing_entries/tws_switch_button_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:tws_widgets/tws_widgets.dart';


void main() {
  usePathUrlStrategy();
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override 
  Widget build(BuildContext context) {
    return PackageLanding<TWSFThemeBase>(
      name: "TWS Foundation View",
      description: (_, Color foreColor) {
        return TextSpan(
          text:
              'This package provides a wide widget collection for UI implementations in TWS solutions.',
          style: TextStyle(
            color: foreColor,
            fontSize: 16,
          ),
        );
      },
      defaultTheme: TWSFDarkTheme(),
      themes: <TWSFThemeBase>[
        TWSFDarkTheme(),
        TWSFThemeLight(),
      ],
      landingEntries: <PackageLandingEntryI<TWSFThemeBase>>[
        twsButtonFlatEntry,
        twsSectionEntry,
        twsCascadeSectionEntry,
        twsDatetimePickerEntry,
        twsConfirmationDialogEntry,
        twsDisplayFlatEntry,
        twsDropupEntry,
        twsFilePickerEntry,
        twsFrameDecorationEntry,
        twsFilePickerEntry,
        twsImageViewerEntry,
        twsIncrementalListEntry,
        twsInputTextEntry,
        twsListTileEntry,
        twsOptionsSelectorEntry,
        twsPagingSelectorEntry,
        twsSectionDividerEntry,
        twsSelectableListEntry,
        twsSwitchButtonEntry,
        twsArticleCreationEntry,
        twsArticleTable,
        twsAutoCompleteFieldEntry,
        twslistViewerEntry,
        twsPhotoTakerEntry,
      ],
    );
  }
}