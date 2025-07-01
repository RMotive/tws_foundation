import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';

/// {reactor} implementation.
///
/// Defines a [ReactorB] implementation for [_EntityCreationFormItem] that works as a dynamic access state simplified object outside its own scope.
final class CreateEntityFormRecordReactor<TEntity extends EntityI<TEntity>> extends ReactorB {
  /// Item model value.
  late TEntity entity;

  /// validation model status.
  bool isValid = true;

  /// Creates a new [CreateEntityFormRecordReactor] instance.
  CreateEntityFormRecordReactor(this.entity);
}
