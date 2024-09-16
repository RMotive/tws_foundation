import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class YardLogsService extends YardLogServiceBase {
  YardLogsService(
    CSMUri host, {
    Client? client,
    CSMHeaders? headers,
  }) : super(
          host,
          'YardLogs',
          client: client,
          headers: headers,
        );
        
  @override
  Effect<SetViewOut<YardLog>> view(SetViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<YardLog>>(actEffect);
  }

  @override
  Effect<SetViewOut<YardLog>> viewInventory(SetViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('viewInventory', options, auth: auth);
    return MainResolver<SetViewOut<YardLog>>(actEffect);
  }
  
  @override
  Effect<MigrationTransactionResult<YardLog>> create(List<YardLog> yardlogs, String auth) async {
    CSMActEffect actEffect = await postList('create', yardlogs, auth: auth);
    return MainResolver<MigrationTransactionResult<YardLog>>(actEffect);
  }

  @override
  Effect<MigrationUpdateResult<YardLog>> update(YardLog yardlog, String auth) async {
    CSMActEffect actEffect = await post('update', yardlog, auth: auth);
    return MainResolver<MigrationUpdateResult<YardLog>>(actEffect);
  }
}
      
