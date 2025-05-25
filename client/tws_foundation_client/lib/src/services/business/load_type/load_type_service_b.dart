import 'package:tws_foundation_client/src/services/business/load_type/load_type_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {abstract} class for [LoadTypeServiceB].
///
/// Defines a base behavior for [LoadTypeServiceB] implementations that are representations of a {SolutionsService} providing operations for the {Security} service at the [FoundationServer].
abstract class LoadTypeServiceB extends FoundationServiceB implements LoadtypeServiceI {
  /// Creates a new [LoadTypeServiceB] instance.
  LoadTypeServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
