part of 'entity_creation_form.dart';

/// [_EntityCreationFormState] Dedicated State class manager for [TWSArticleCreation] widget.
/// Add or remove current or change [TWSArticleCreationStackItem] selection, notifying subscribers.
final class _EntityCreationFormReactor<TModel> extends ReactorB {
  /// List of states for added items.
  late List<EntityCreationFormItemReactor<TModel>> states;

  /// Method to build new generic items.
  late TModel Function() modelFactory;

  /// selecte item index.
  int current = 0;

  _EntityCreationFormReactor(this.modelFactory) {
    TModel model = modelFactory();

    states = <EntityCreationFormItemReactor<TModel>>[
      EntityCreationFormItemReactor<TModel>(model),
    ];
  }

  void removeItem(int index) {
    states.removeAt(index);

    current = 0;
    react();
  }

  void addItem() {
    final TModel modelFactoried = modelFactory();

    EntityCreationFormItemReactor<TModel> newState =
        EntityCreationFormItemReactor<TModel>(modelFactoried);
    states.insert(0, newState);
    current = 0;
    react();
  }

  void changeSelection(int index) {
    current = index;
    react();
  }
}
