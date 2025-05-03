import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {private} {implementation} class for [SolutionsService].
final class SolutionsService extends SolutionsServiceB {
  SolutionsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'solutions',
        );

  @override
  FoundationFutureResolver<ViewOutput<Solution>> view(ViewInput<Solution> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<Solution>>(
      await postSecure<ViewInput<Solution>>(
        'view',
        input,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<Solution>> create(List<Solution> solutions, String auth) async {
    return FoundationResponseResolver<BatchOperationOutput<Solution>>(
      await postListSecure<Solution>(
        'create',
        solutions,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<Solution>> update(UpdateInput<Solution> input, String auth) async {
    return FoundationResponseResolver<UpdateOutput<Solution>>(
      await postSecure(
        'update',
        input,
      ),
    );
  }
}
