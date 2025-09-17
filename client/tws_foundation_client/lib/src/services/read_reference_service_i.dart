import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Defines a contract for {read} operations for [ServiceI] implementations, filtering by reference property.
abstract interface class ReadReferenceServiceI<TEntity extends EntityI<TEntity>> {
  /// Creates a new [ReadReferenceServiceI] instance.
  const ReadReferenceServiceI();

  /// Generates a {read} complex object from [TEntity] entity.
  ///
  ///
  /// [reference] string filter to fetch the [TEntity] with the unique reference property.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<TEntity?> read(String reference, String auth);
}
