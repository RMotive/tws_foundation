import 'package:csm_client/csm_client.dart';
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
  Effect<SetViewOut<YardLog>> view(SetViewOptions<YardLog> options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<YardLog>>(actEffect);
  }

  @override
  Effect<SetViewOut<YardLog>> viewInventory(SetViewOptions<YardLog> options, String auth) async {
    CSMActEffect actEffect = await post('viewInventory', options, auth: auth);
    return MainResolver<SetViewOut<YardLog>>(actEffect);
  }
  
  @override
  Effect<SetBatchOut<YardLog>> create(List<YardLog> yardlogs, String auth) async {
    CSMActEffect actEffect = await postList('create', yardlogs, auth: auth);
    return MainResolver<SetBatchOut<YardLog>>(actEffect);
  }

  @override
  Effect<RecordUpdateOut<YardLog>> update(YardLog yardlog, String auth) async {
    CSMActEffect actEffect = await post('update', yardlog, auth: auth);
    return MainResolver<RecordUpdateOut<YardLog>>(actEffect);
  }
}
      
