import 'package:csm_view/csm_view.dart';

/// {reactor} implementation.
///
/// Defines a [ReactorB] implementation for [_EntityCreationFormItem] that works as a dynamic access state simplified object outside its own scope.
final class EntityCreationFormItemReactor<T> extends ReactorB {
  /// Item model value.
  late T _model;

  /// validation model status.
  late bool _valid;

  EntityCreationFormItemReactor(this._model) : _valid = true;

  T get model => _model;
  bool get valid => _valid;

  /// Update the model values without notify suscribers.
  void updateModel(T newModel) => _model = newModel;

  /// Update the model values notifying the suscribers.
  void updateModelRedrawing(T newModel) {
    _model = newModel;
    react();
  }

  /// Update the validations status value without notify suscribers.
  void updateInvalid(bool newInvalid) => _valid = newInvalid;

  /// Update the model values notifying the suscribers.
  void updateInvalidRedrawing(bool newInvalid) {
    _valid = newInvalid;
    react();
  }
}
