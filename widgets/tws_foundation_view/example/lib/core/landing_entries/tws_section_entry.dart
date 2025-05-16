
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeBase> twsSectionEntry =
    PackageLandingEntry<TWSFThemeBase>(
      name: "TWS Section",
      description:
          (TWSFThemeBase theme, Color foreColor) => TextSpan(
            text: "Defined to handle section separator along pages sections.",
          ),
      contentBuilder: (BuildContext ctx, Size size, TWSFThemeBase theme) {
        return TWSSection(title: "Section Example", content: Container());
      },
    );
