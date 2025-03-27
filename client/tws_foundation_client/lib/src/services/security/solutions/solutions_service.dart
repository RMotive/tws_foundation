import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [SolutionsServiceBase] implementation.
final class SolutionsService extends SolutionsServiceBase {
  /// Generates a new [SolutionsService] instance, and implementation of [SolutionsServiceBase] providing methods to handle
  /// [Solution] set records and its data.
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
  Effect<SetViewOutput<Solution>> view(SetViewOutput<Solution> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return ServiceResolver<SetViewOutput<Solution>>(actEffect);
  }

  @override
  Effect<SetViewOutput<Solution>> create(List<Solution> solutions, String auth) async {
    CSMActEffect actEffect = await twsPostList('create', solutions, auth: auth);
    return ServiceResolver<SetViewOutput<Solution>>(actEffect);
  }

  @override
  Effect<EntityUpdateOutput<Solution>> update(Solution solution, String auth) async {
    CSMActEffect actEffect = await twsPost('update', solution, auth: auth);
    return ServiceResolver<EntityUpdateOutput<Solution>>(actEffect);
  }
}
