
import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:example/core/adapters/view_consume_adapters.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_widgets/tws_widgets.dart';

PackageLandingEntry<TWSFThemeBase> twsAutoCompleteFieldEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWSAutoCompleteField", 
  description:
      (TWSFThemeBase theme, Color foreColor) => TextSpan(
        text:
            "This component stores a list of posibles options to select for the user.\n Performs a options filter based on user input text. \nThe Data is fetched throw Future async methods or non-async methods.",
      ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    return TWSFLandingFrame(
      child: Column(
          spacing: 10,
          children: <Widget>[
            TWSAutoCompleteField<String>(
              width: 200,
              label: "Native Data",
              nativeList: <String>["value1", 'value2', 'value3', 'value4', 'value5'],
              displayValue: (String? value) => value ?? "---",
              onChanged:(String? selection) {
                print("Current selection: $selection");
              }, 
            ),
            TWSAutoCompleteField<TrailerClass>(
              width: 200,
              label: "Async Data",
              quantityResults: 5,
              adapter: const ViewConsumeAdapter(),
              displayValue: (TrailerClass? value) => value?.name ?? "---",
              onChanged:(TrailerClass? selection) {
                print("Current selection: ${selection?.name}");
              }, 
            ),
          ],
        ),
    );
  }
);