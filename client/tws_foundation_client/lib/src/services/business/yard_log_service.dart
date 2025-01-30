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
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<YardLog>>(actEffect);
  }

  @override
  Effect<SetViewOut<YardLog>> viewInventory(SetViewOptions<YardLog> options, String auth) async {
    CSMActEffect actEffect = await twsPost('viewInventory', options, auth: auth);
    return MainResolver<SetViewOut<YardLog>>(actEffect);
  }
  
  @override
  Effect<SetBatchOut<YardLog>> create(List<YardLog> yardlogs, String auth) async {
    CSMActEffect actEffect = await twsPostList('create', yardlogs, auth: auth);
    return MainResolver<SetBatchOut<YardLog>>(actEffect);
  }

  @override
  Effect<RecordUpdateOut<YardLog>> update(YardLog yardlog, String auth) async {
    CSMActEffect actEffect = await twsPost('update', yardlog, auth: auth);
    return MainResolver<RecordUpdateOut<YardLog>>(actEffect);
  }

  @override
  Effect<ExportOut> exportView(SetViewOptions<YardLog> options, String auth) async {
    CSMActEffect actEffect = await twsPost('exportView', options, auth: auth);

    return MainResolver<ExportOut>(actEffect);
  }

  @override
  Effect<ExportOut> exportInventory(SetViewOptions<YardLog> options, String auth) async {
    CSMActEffect actEffect = await twsPost('exportInventory', options, auth: auth);

    return MainResolver<ExportOut>(actEffect);
  }
}
      
