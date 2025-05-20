
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsSectionEntry = PackageLandingEntry<TWSFThemeB>(
      name: "TWS Section",
      description:
          (TWSFThemeB theme, Color foreColor) => TextSpan(
            text: "Defined to handle section separator along pages sections.",
          ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
        return TWSSection(title: "Section Example", content: Container());
      },
    );
