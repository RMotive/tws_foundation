import 'package:tws_foundation_client/src/services/business/load_types/load_types_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {abstract} class for [LoadTypesServiceB].
///
/// Defines a base behavior for [LoadTypesServiceB] implementations that are representations of a {SolutionsService} providing operations for the {Security} service at the [FoundationServer].
abstract class LoadTypesServiceB extends FoundationServiceB implements LoadTypesServiceI {
  /// Creates a new [LoadTypesServiceB] instance.
  LoadTypesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
