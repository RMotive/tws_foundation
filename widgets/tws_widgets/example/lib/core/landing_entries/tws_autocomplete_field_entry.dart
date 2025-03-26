part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsAutoCompleteFieldEntry = CSMPackageLandingEntry(
  name: "TWSAutoCompleteField", 
  description: RichText(
    text: TextSpan(
      text:
          "This component stores a list of posibles options to select for the user.\n Performs a options filter based on user input text. \nThe Data is fetched throw Future async methods or non-async methods.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: CSMSpacingColumn(
        spacing: 10,
        children: <Widget>[
          TWSAutoCompleteField<String>(
            label: "Native Data",
            displayValue: (String? value) => value ?? "---",
            onChanged:(String? selection) {
              print("Current selection: $selection");
            }, 
            nativeList: <String>["value1", 'value2', 'value3', 'value4', 'value5'],
          ),
          TWSAutoCompleteField<Feature>(
            label: "Async Data",
            displayValue: (Feature? value) => value?.name ?? "---",
            onChanged:(Feature? selection) {
              print("Current selection: ${selection?.name}");
            }, 
            adapter: const ViewConsumeAdapter(),
          ),
        ],
      ),
    );
  }
);