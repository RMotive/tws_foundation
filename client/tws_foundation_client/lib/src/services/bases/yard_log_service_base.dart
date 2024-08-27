import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class YardLogServiceBase extends CSMServiceBase {
  YardLogServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  /// Transaction to generate a set view object.
  Effect<MigrationView<YardLog>> view(MigrationViewOptions options, String auth);

  Effect<MigrationTransactionResult<YardLog>> create(List<YardLog> yardlogs, String auth);

  Effect<MigrationUpdateResult<YardLog>> update(YardLog yardlog, String auth);


}
