
import 'package:csm_view/csm_view.dart';
import 'package:example/core/Frames/twsf_landing_frame.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeBase> twsPagingSelectorEntry = PackageLandingEntry<TWSFThemeBase>(
  name: "TWS Paging selector",
  description:
          (TWSFThemeBase theme, Color foreColor) => TextSpan(
            text: "Widget Row that shows paging data and paging selector. Ideal for data tables.",
          ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
    return TWSFLandingFrame(
      child: TWSPagingSelector(
          items: 20,
          total: 199,
          pages: 3,
          size: 25,
          sizes: <int>[25,50,75,100],
          onChange:(int page, int size) {
            print('Selections - Pages: $page; Size: $size');
          },
        ),
    );
  },
);
