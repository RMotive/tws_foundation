import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// Defines a contract for {view} operations for [ExportServiceI] implementations.
abstract interface class ExportServiceI<TEntity extends EntityI<TEntity>> {
  /// Creates a new [ExportServiceI] instance.
  const ExportServiceI();

  /// Creates a downloadable export file from a [TEntity] view.
  ///
  ///
  /// [input] view file content parameters.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ExportOutput> exportView(ViewInput<TEntity> input, String auth);
}
