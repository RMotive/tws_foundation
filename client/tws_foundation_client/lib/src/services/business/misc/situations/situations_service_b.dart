import 'package:tws_foundation_client/src/services/business/misc/situations/situatutions_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {abstract} class for [SituationsServiceB].
///
/// Defines a base behavior for [SituationsServiceB] implementations that are representations of a {SolutionsService} providing operations for the {Security} service at the [FoundationServer].
abstract class SituationsServiceB extends FoundationServiceB implements SituationsServiceI {
  /// Creates a new [SituationsServiceB] instance.
  SituationsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
