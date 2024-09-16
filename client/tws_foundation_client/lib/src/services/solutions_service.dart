import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


final class SolutionsService extends SolutionsServiceBase {
  SolutionsService(
    CSMUri host, {
    Client? client,
    CSMHeaders? headers,
  }) : super(
          host,
          'Solutions',
          client: client,
          headers: headers,
        );

  @override
  Effect<SetViewOut<Solution>> view(SetViewOptions<Solution> options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<Solution>>(actEffect);
  }

  @override
  Effect<MigrationTransactionResult<Solution>> create(List<Solution> solutions, String auth) async {
    CSMActEffect actEffect = await postList('create', solutions, auth: auth);
    return MainResolver<MigrationTransactionResult<Solution>>(actEffect);
  }

  @override
  Effect<MigrationUpdateResult<Solution>> update(Solution solution, String auth) async {
    CSMActEffect actEffect = await post('update', solution, auth: auth);
    return MainResolver<MigrationUpdateResult<Solution>>(actEffect);
  }
}
