 part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsConfirmationDialogEntry = CSMPackageLandingEntry(
  name: "TWS Confirmation Dialog", 
  description: RichText(
    text: TextSpan(
      text: "Displays a dialog window with a header, body content and confirmation action buttons.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      child: TWSButtonFlat(
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
    );
  }
);