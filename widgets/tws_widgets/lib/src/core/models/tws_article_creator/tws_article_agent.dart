import 'package:flutter/foundation.dart';

/// [TWSArticleCreatorAgent] Dedicated generic class for [TWSArticleCreator] widget.
/// Contains a create method for listeners notifications.
final class TWSArticleCreatorAgent<TModel> extends ChangeNotifier {
  TWSArticleCreatorAgent();

  /// Method triggered for creation items in [Article] & [TWSArticleCreator]. 
  void create() {
    notifyListeners();
  }
}
