import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Defines a contract for {view} operations for [IService] implementations.
abstract interface class ViewServiceI<TEntity extends IEntity<TEntity>> {
  /// Creates a new [ViewServiceI] instance.
  const ViewServiceI();

  /// Generates a {view} complex object from [TEntity] entity.
  ///
  ///
  /// [options] how the method will build the {View} result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<TEntity>> view(ViewInput<TEntity> input, String auth);
}
