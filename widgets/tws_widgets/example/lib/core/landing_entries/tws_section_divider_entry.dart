
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/tws_widgets.dart';

PackageLandingEntry<TWSFThemeBase> twsSectionDividerEntry =
    PackageLandingEntry<TWSFThemeBase>(
      name: "TWS Section Divider",
      description:
          (TWSFThemeBase theme, Color foreColor) => TextSpan(
            text: "Manage the creation and submit of generic [TModel] items",
          ),
      contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
        return TWSSectionDivider(text: "Divider example");
      },
    );
