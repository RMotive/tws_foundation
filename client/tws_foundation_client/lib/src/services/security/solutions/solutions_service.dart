import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/outputs/entity_update_output.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/security/solutions/solution.dart';
import 'package:tws_foundation_client/src/services/security/solutions/solutions_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [SolutionsServiceBase] implementation.
final class SolutionsService extends SolutionsServiceBase {
  /// Generates a new [SolutionsService] instance, and implementation of [SolutionsServiceBase] providing methods to handle
  /// [Solution] set records and its data.
  SolutionsService(
    Uri host, {
    Client? client,
    Headers? headers,
  }) : super(
          host,
          'Solutions',
          client: client,
          headers: headers,
        );

  @override
  Effect<SetViewOutput<Solution>> view(SetViewOutput<Solution> options, String auth) async {
    ResponseController actEffect = await postSecure('view', options, authToken: auth);
    return FoundationResponseResolver<SetViewOutput<Solution>>(actEffect);
  }

  @override
  Effect<EntityBatchOperation<Solution>> create(List<Solution> solutions, String auth) async {
    ResponseController actEffect = await postListSecure('create', solutions, auth: auth);
    return FoundationResponseResolver<EntityBatchOperation<Solution>>(actEffect);
  }

  @override
  Effect<EntityUpdateOutput<Solution>> update(Solution solution, String auth) async {
    ResponseController actEffect = await postSecure('update', solution, authToken: auth);
    return FoundationResponseResolver<EntityUpdateOutput<Solution>>(actEffect);
  }
}
