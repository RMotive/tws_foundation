
import 'package:csm_view/csm_view.dart';
import 'package:example/core/adapters/view_table_adapter.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

PackageLandingEntry<TWSFThemeB> twsArticleTable = PackageLandingEntry<TWSFThemeB>(
  name: "TWSArticleTable", 
  description:
          (TWSFThemeB theme, Color foreColor) => TextSpan(
            text: "Create a data grid table, with custom headers, content and interactable rows and drawer options.",
          ),
  contentBuilder: (BuildContext ctx, Size size, TWSFThemeB theme) {
    final TWSArticleTableAgent agent = TWSArticleTableAgent();
    return ColoredBox(
      color: theme.page.back,
      child: Column(
        spacing: 10,
        children: <Widget>[
          Expanded(
            child: TWSArticleTable<TrailerClass>(
              size: 25,
              sizes: <int>[25, 50, 75, 100],
              adapter: const TableAdapter(),
              agent: agent,
              fields: <TWSArticleTableFieldOptions<TrailerClass>>[
                TWSArticleTableFieldOptions<TrailerClass>(
                  'Name',
                  (TrailerClass item, int index, BuildContext ctx) => item.name,
                ),
                TWSArticleTableFieldOptions<TrailerClass>(
                  'Description',
                  (TrailerClass item, int index, BuildContext ctx) => item.description ?? "---",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
);