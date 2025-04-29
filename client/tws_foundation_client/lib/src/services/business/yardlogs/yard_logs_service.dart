import 'package:tws_foundation_client/src/services/business/yardlogs/yard_log.dart';
import 'package:tws_foundation_client/src/services/business/yardlogs/yard_logs_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class YardLogsService extends YardLogsServiceBase {
  ///
  YardLogsService(
    Uri host, {
    Client? client,
  }) : super(
          host,
          'YardLogs',
          client: client,
        );

  ///
  @override
  Effect<SetViewOutput<YardLog>> view(SetViewInput<YardLog> input, String auth) async {
    ResponseController actEffect = await twsPost('view', input, auth: auth);

    return ServiceResolver<SetViewOutput<YardLog>>(actEffect);
  }
}
