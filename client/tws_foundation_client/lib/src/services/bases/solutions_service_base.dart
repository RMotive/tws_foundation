import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

typedef Effect<TEstela extends CSMEncodeInterface> = Future<MainResolver<TEstela>>;
typedef MResolver<TEstela extends CSMEncodeInterface> = MainResolver<TEstela>;

abstract class SolutionsServiceBase extends CSMServiceBase {
  SolutionsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Solution>> view(SetViewOptions<Solution> options, String auth);

  /// Transaction to create solutions entities.
  Effect<SetBatchOut<Solution>> create(List<Solution> solutions, String auth);

  ///
  Effect<RecordUpdateOut<Solution>> update(Solution solution, String auth);
}
