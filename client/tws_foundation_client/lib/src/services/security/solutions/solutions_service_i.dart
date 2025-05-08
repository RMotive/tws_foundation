import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [SolutionsServiceI].
///
/// Defines base contract for [SolutionsServiceI] implementations that specifies the methods to have providing [Solution] based operations and management.
abstract interface class SolutionsServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [SolutionsServiceI] instance.
  SolutionsServiceI(super.host, super.servicePath);

  /// Generates a complex [View] for [Solution] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Solution>> view(ViewInput<Solution> input, String auth);

  /// Creates a [Solution] collection.
  ///
  ///
  /// [solutions] records to create and store. ([Solution.Id] property must be 0, [Solution.Timestamp] always will be overriden to the exact moment is stored at the data storages).
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<BatchOperationOutput<Solution>> create(List<Solution> solutions, String auth);

  /// Updates a [Solution] based on the [Solution.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Solution>> update(UpdateInput<Solution> input, String auth);
}
