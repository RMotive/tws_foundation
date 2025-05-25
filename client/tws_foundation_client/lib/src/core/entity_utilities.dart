import 'package:csm_client/csm_client.dart';

/// List extension for Invalidations methods for [EntityI] classes.
extension EntityInvalidationList<T extends EntityI<T>> on List<EntityInvalidation<T>>{

  /// Validate a dependecy class and cast the [EntityI] result into the original [EntityI] type List if result is not empty.
  /// - [entity] Main entity that contains the dependency to evaluate.
  /// - [evaluate] Dependency to evaluate in main entity.
  validateDependency(T entity, EntityI<Object?> evaluate) {
    List<EntityInvalidation<Object?>> results = evaluate.evaluate();
    if(results.isNotEmpty) {
      /// For each invalidation result, perfom a cast values and insert the result into the original list.
      for (EntityInvalidation<Object?> invalidation in results) {
        EntityInvalidation<T> cast = EntityInvalidation<T>(
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
