import 'package:csm_client_core/csm_client_core.dart';

/// List extension for Invalidations methods for [IEntity] classes.
extension EntityErrorsList<T extends IEntity<T>> on List<EntityErrors<T>>{

  /// Validate a dependecy class and cast the [IEntity] result into the original [IEntity] type List if result is not empty.
  /// - [entity] Main entity that contains the dependency to evaluate.
  /// - [evaluate] Dependency to evaluate in main entity.
  void validateDependency(T entity, IEntity<Object?> evaluate) {
    List<EntityErrors<Object?>> errors = evaluate.evaluate(<EntityErrors<Object?>>[]);
    if(errors.isNotEmpty) {
      /// For each invalidation result, perfom a cast values and insert the result into the original list.
      for (EntityErrors<Object?> invalidation in errors) {
        EntityErrors<T> cast = EntityErrors<T>(
          entity,
          PropertyInfo(
            invalidation.property.name,
            invalidation.property.type,
            invalidation.property.value,
          ),
          invalidation.reason,
          invalidation.rules,
        );
        /// Insert the cast result into the original list.
        add(cast);
      }
    }
  }
}
