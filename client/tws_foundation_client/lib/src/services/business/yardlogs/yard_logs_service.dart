import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
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
    ResponseController actEffect = await postSecure('view', input, authToken: auth);

    return FoundationResponseResolver<SetViewOutput<YardLog>>(actEffect);
  }
}
