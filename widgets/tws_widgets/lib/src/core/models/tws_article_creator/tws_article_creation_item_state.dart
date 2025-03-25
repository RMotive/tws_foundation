

import 'package:csm_view/csm_view.dart';

/// [TWSArticleCreatorItemState] Dedicated State class manager for [TWSArticleCreationStackItem] widget.
/// Set the models/items values and validations status.
final class TWSArticleCreatorItemState<TModel> extends CSMStateBase {
  /// Item model value.
  late TModel _model;
  /// validation model status.
  late bool _valid;

  TWSArticleCreatorItemState(this._model) : _valid = true;


  TModel get model => _model;
  bool get valid => _valid;

  /// Update the model values without notify suscribers.
  void updateModel(TModel newModel) => _model = newModel;

  /// Update the model values notifying the suscribers.
  void updateModelRedrawing(TModel newModel) {
    _model = newModel;
    effect();
  }

  /// Update the validations status value without notify suscribers.
  void updateInvalid(bool newInvalid) => _valid = newInvalid;

  /// Update the model values notifying the suscribers.
  void updateInvalidRedrawing(bool newInvalid) {
    _valid = newInvalid;
    effect();
  }
}
