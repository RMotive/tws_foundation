import 'package:csm_client/csm_client.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/widgets/tws_article_table/tws_article_table.dart';

abstract interface class TWSArticleTableAdapter<TSet extends EntityB<TSet>> {
  Future<ViewOutput<TSet>> consume(int page, int range, List<ViewOrdering> orderings);

  TWSArticleTableEditor? composeEditor(TSet set, void Function() closeReinvoke, BuildContext context);
  Widget composeViewer(TSet set, BuildContext context);
  void onRemoveRequest(TSet set, BuildContext context);
}
