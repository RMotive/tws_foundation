import 'package:csm_foundation_services/csm_foundation_services.dart';
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
  Effect<MigrationView<Solution>> view(MigrationViewOptions options, String auth);

  /// Transaction to create solutions entities.
  Effect<MigrationTransactionResult<Solution>> create(List<Solution> solutions, String auth);

  ///
  Effect<MigrationUpdateResult<Solution>> update(Solution solution, String auth);

  ///
  Effect<Solution> delete(Solution solution, String auth);
}
