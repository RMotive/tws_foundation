import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {abstract} class for [SolutionsServiceB].
///
/// Defines a base behavior for [SolutionsServiceB] implementations that are representations of a {SolutionsService} providing operations for the {Security} service at the [FoundationServer].
abstract class SolutionsServiceB extends FoundationServiceB implements SolutionsServiceI {
  /// Creates a new [SolutionsServiceB] instance.
  SolutionsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}
