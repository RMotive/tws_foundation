part of '../landing_view/landing_view.dart';

CSMPackageLandingEntry _twsPagingSelectorEntry = CSMPackageLandingEntry(
  name: "TWS Paging selector",
  description: RichText(
    text: TextSpan(
      text:
          "Widget Row that shows paging data and paging selector. Ideal for data tables.",
    ),
  ),
  composeLanding: (BuildContext ctx) {
    return TWSFLandingFrame(
      width: 600,
      child: TWSPagingSelector(
        items: 20,
        total: 199,
        pages: 3,
        size: 25,
        sizes: <int>[25,50,75,100],
        onChange:(int page, int size) {
          print('Selections - Pages: $page; Size: $size');
        },
      )
    );
  },
);
