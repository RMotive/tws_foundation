import 'package:csm_view/csm_view.dart';

/// {reactor} implementation.
///
/// Defines a [ReactorB] implementation for [_EntityCreationFormItem] that works as a dynamic access state simplified object outside its own scope.
final class EntityCreationFormItemReactor<T> extends ReactorB {
  /// Item model value.
  late T _entity;

  ///
  T get model => _entity;

  /// validation model status.
  late bool _isValid;

  /// Creates a new [EntityCreationFormItemReactor] instance.
  EntityCreationFormItemReactor(this._entity) : _isValid = true;

  bool get valid => _isValid;

  /// Update the model values without notify suscribers.
  void updateModel(T newModel) => _entity = newModel;

  /// Update the model values notifying the suscribers.
  void updateModelRedrawing(T newModel) {
    _entity = newModel;
    react();
  }

  /// Update the validations status value without notify suscribers.
  void updateInvalid(bool newInvalid) => _isValid = newInvalid;

  /// Update the model values notifying the suscribers.
  void updateInvalidRedrawing(bool newInvalid) {
    _isValid = newInvalid;
    react();
  }
}
