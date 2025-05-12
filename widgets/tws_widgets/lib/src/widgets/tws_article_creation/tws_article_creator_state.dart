part of 'tws_article_creator.dart';
/// [_TWSArticleCreationState] Dedicated State class manager for [TWSArticleCreation] widget.
/// Add or remove current or change [TWSArticleCreationStackItem] selection, notifying subscribers.
final class _TWSArticleCreationState<TModel> extends ReactorB {
  /// List of states for added items.
  late List<TWSArticleCreatorItemState<TModel>> states;
  
  /// Method to build new generic items.
  late TModel Function() modelFactory;
  
  /// selecte item index.
  int current = 0;

  _TWSArticleCreationState(this.modelFactory) {
    TModel model = modelFactory();

    states = <TWSArticleCreatorItemState<TModel>>[
      TWSArticleCreatorItemState<TModel>(model),
    ];
  }
  
  void removeItem(int index) {
    states.removeAt(index);

    current = 0;
    react();
  }

  void addItem() {
    final TModel modelFactoried = modelFactory();

    TWSArticleCreatorItemState<TModel> newState = TWSArticleCreatorItemState<TModel>(modelFactoried);
    states.insert(0, newState);
    current = 0;
    react();
  }

  void changeSelection(int index) {
    current = index;
    react();
  }
}
