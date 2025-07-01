import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/yardlogs/yard_logs_service_b.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class YardLogsService extends YardLogsServiceB {
  ///
  YardLogsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'yardLogs',
        );

  @override
  FoundationFutureResolver<ViewOutput<YardLog>> view(ViewInput<YardLog> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<YardLog>>(
      await postSecure<ViewInput<YardLog>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<YardLog>> create(List<YardLog> yardlogs, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<YardLog>>(
      await postListSecure<YardLog>(
        'create',
        yardlogs,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<YardLog>> update(UpdateInput<YardLog> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<YardLog>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }
}
