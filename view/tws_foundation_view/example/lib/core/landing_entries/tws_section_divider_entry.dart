
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsSectionDividerEntry = PackageLandingEntry<TWSFThemeB>(
      name: "TWS Section Divider",
      description:
          (TWSFThemeB theme, Color foreColor) => TextSpan(
            text: "Manage the creation and submit of generic [TModel] items",
          ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
        return TWSSectionDivider(text: "Divider example");
      },
    );
