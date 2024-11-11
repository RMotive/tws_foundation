import 'package:csm_client/csm_client.dart';
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
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Solution>>(actEffect);
  }

  @override
  Effect<SetBatchOut<Solution>> create(List<Solution> solutions, String auth) async {
    CSMActEffect actEffect = await twsPostList('create', solutions, auth: auth);
    return MainResolver<SetBatchOut<Solution>>(actEffect);
  }

  @override
  Effect<RecordUpdateOut<Solution>> update(Solution solution, String auth) async {
    CSMActEffect actEffect = await twsPost('update', solution, auth: auth);
    return MainResolver<RecordUpdateOut<Solution>>(actEffect);
  }
}
