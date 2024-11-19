import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class YardLogServiceBase extends TWSServiceBase {
  YardLogServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<YardLog>> view(SetViewOptions<YardLog> options, String auth);

  Effect<SetViewOut<YardLog>> viewInventory(SetViewOptions<YardLog> options, String auth);

  Effect<SetBatchOut<YardLog>> create(List<YardLog> yardlogs, String auth);

  Effect<RecordUpdateOut<YardLog>> update(YardLog yardlog, String auth);
}
