import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

typedef Effect<TEstela extends CSMEncodeInterface> = Future<MainResolver<TEstela>>;
typedef MResolver<TEstela extends CSMEncodeInterface> = MainResolver<TEstela>;

/// [API] for any [SolutionsServiceBase] implementations.
abstract class SolutionsServiceBase extends TWSServiceBase {
  /// Generates a new [SolutionsServiceBase] instance to store mandatory proeprties for any [SolutionsServiceBase] implementation.
  SolutionsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Generates a complex [View] for [Solution] set.
  ///
  /// [options] : how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] : server authorization token.
  Effect<SetViewOut<Solution>> view(SetViewOptions<Solution> options, String auth);

  /// Creates a [Solution] collection.
  ///
  /// [solutions] : records to create and store. ([Solution.Id] property must be 0, [Solution.Timestamp] always will be overriden to the exact moment is stored at the data storages).
  ///
  /// [auth] : server authorization token.
  Effect<SetBatchOut<Solution>> create(List<Solution> solutions, String auth);

  /// Updates a [Solution] based on the [Solution.Id] pointer.
  ///
  /// [solution] : record properties to update at the data storage.
  ///
  /// [auth] : server authorization token.
  Effect<RecordUpdateOut<Solution>> update(Solution solution, String auth);
}
