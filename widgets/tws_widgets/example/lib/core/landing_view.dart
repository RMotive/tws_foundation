import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

part 'landing_entries/tws_button_flat_entry.dart';
part 'landing_entries/tws_section_entry.dart';
part 'landing_entries/tws_cascade_section_entry.dart';
part 'landing_entries/tws_datetime_picker_entry.dart';

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
              child: TWSButtonFlat<TWSFThemeBase>(
                label: "refresh",
                onTap: () {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: TWSButtonFlat<TWSFThemeBase>(
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
              _tws_datetime_picker_entry,
            ],
          ),
        ),
      ],
    );
  }
}