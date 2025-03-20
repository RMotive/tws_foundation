 part of '../landing_view.dart';

CSMPackageLandingEntry _twsConfirmationDialogEntry = CSMPackageLandingEntry(
  name: "TWS Confirmation Dialog", 
  description: RichText(
    text: TextSpan(
      text: "Custom TWS Confirmation dialog component",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return Column(
      children: <Widget>[
        TWSButtonFlat(
          label: "Show dialog",
          onTap: (){
            showDialog(context: ctx, 
              builder:(BuildContext context) {
                return TWSConfirmationDialog(
                  onClose: () => print("Closing dialog...."),
                  onAccept: () => print("Tap on Ok button...."),
                );
              },
            );
          }
        ),
      ],
    );
  }
);