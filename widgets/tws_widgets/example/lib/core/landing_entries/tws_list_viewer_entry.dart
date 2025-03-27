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
    final CSMConsumerAgent consumerAgent = CSMConsumerAgent(); 
      Future<SetViewOut<Feature>> features() async {
        await Future<void>.delayed(Duration(seconds: 2));
        return SetViewOut<Feature>(mockFeatures, 1, DateTime.now(), 1, 11, 11);
      }

    return TWSFLandingFrame(
      child: CSMSpacingRow(
        spacing: 10,
        children: <Widget>[
          Expanded(
            child: TwsListViewer<Feature>(
              title: "Features async data", 
              agent: consumerAgent ,
              consume:() => features(),
              tileTitle:(Feature set) {
                return set.name;
              },
            ),
          ),
          Expanded(
            child: TwsListViewer<Feature>(
              title: "Features native data", 
              tilesContent: mockFeatures,
              tileTitle:(Feature set) {
                return set.name;
              },
            ),
          ),
        ],
      ),
    );
  }
);