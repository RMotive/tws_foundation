import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/business/yardlogs/yard_log.dart';
import 'package:tws_foundation_client/src/services/foundation_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [YardLog] entity service base
abstract class YardLogsServiceBase extends FoundationServiceB {
  /// Creates a new [YardLogsServiceBase] instance.
  ///
  /// [host] server host address.
  /// [servicePath] service path address.
  /// [client] custom network [Client] to testing/quality purposes.
  YardLogsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  ///
  Effect<SetViewOutput<YardLog>> view(SetViewInput<YardLog> input, String auth);
}
