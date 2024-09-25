import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class YardLogServiceBase extends CSMServiceBase {
  YardLogServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<YardLog>> view(SetViewOptions<YardLog> options, String auth);

  Effect<SetViewOut<YardLog>> viewInventory(SetViewOptions<YardLog> options, String auth);

  Effect<MigrationTransactionResult<YardLog>> create(List<YardLog> yardlogs, String auth);

  Effect<MigrationUpdateResult<YardLog>> update(YardLog yardlog, String auth);


}
