import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Defines a contract for {view} operations for [ServiceI] implementations.
abstract interface class CreateServiceI<TEntity extends EntityI<TEntity>> {
  /// Creates a new [CreateServiceI] instance.
  const CreateServiceI();

   /// Creates a [TEntity] collection.
  ///
  ///
  /// [entities] records to create and store. ([TEntity.Id] property must be 0, [TEntity.Timestamp] always will be overriden to the exact moment is stored at the data storages).
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<BatchOperationOutput<TEntity>> create(List<TEntity> entities, String auth);
}
