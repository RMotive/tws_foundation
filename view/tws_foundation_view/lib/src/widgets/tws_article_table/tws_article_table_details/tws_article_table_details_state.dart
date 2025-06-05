part of '../tws_article_table.dart';

final class _TWSArticleTableDetailsState extends ReactorB {
  bool _editing = false;

  bool get editing => _editing;
  set editing(bool value) {
    _editing = value;
    react();
  }
}
