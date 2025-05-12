part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twslistViewerEntry = CSMPackageLandingEntry(
  name: "TWS List Viewer", 
  description: RichText(
    text: TextSpan(
      text:
          "A simple list component to show a section that contains a list with a title and subtitle.",
    ),
  ), 
  composeLanding: (BuildContext ctx) {
    final AsyncWidgetController consumerAgent = AsyncWidgetController(); 
      Future<SetViewOutput<TrailerClass>> features() async {
        await Future<void>.delayed(Duration(seconds: 2));
        return SetViewOutput<TrailerClass>(mockFeatures, 1, DateTime.now(), 1, 11, 11);
      }

    return TWSFLandingFrame(
      child: CSMSpacingRow(
        spacing: 10,
        children: <Widget>[
          Expanded(
            child: TwsListViewer<TrailerClass>(
              title: "Features async data", 
              agent: consumerAgent ,
              consume:() => features(),
              tileTitle:(TrailerClass set) {
                return set.name;
              },
            ),
          ),
          Expanded(
            child: TwsListViewer<TrailerClass>(
              title: "Features native data", 
              tilesContent: mockFeatures,
              tileTitle:(TrailerClass set) {
                return set.name;
              },
            ),
          ),
        ],
      ),
    );
  }
);