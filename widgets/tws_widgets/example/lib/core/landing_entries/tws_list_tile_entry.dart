part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsListTileEntry = CSMPackageLandingEntry(
  name: "TWS List Tile",
  description: RichText(
    text: TextSpan(
      text:
          "Simple self-administered statefull list tile. Shows simple text data and updates it's internal state on mouse events.",
    ),
  ),
  composeLanding: (BuildContext ctx) {
    TWSFThemeBase theme = getTheme();
    return TWSFLandingFrame(
      child: TwsListTile(
        textColor: theme.primaryControlColor.foreAlt ?? theme.primaryControlColor.fore,
        backgroundColor: theme.primaryControlColor.highlight,
        label: "Tile exmaple",
        onTap: (bool selected) => print("Tile tap..."),
      ),
    );
  },
);
