import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class YardLogsService extends YardLogServiceBase {
  YardLogsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'YardLogs',
          client: client,
        );
        
  @override
  Effect<MigrationView<YardLog>> view(MigrationViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<MigrationView<YardLog>>(actEffect);
  }
  
  @override
  Effect<MigrationTransactionResult<YardLog>> create(List<YardLog> trucks, String auth) async {
    CSMActEffect actEffect = await postList('create', trucks, auth: auth);
    return MainResolver<MigrationTransactionResult<YardLog>>(actEffect);
  }

  @override
  Effect<MigrationUpdateResult<YardLog>> update(YardLog solution, String auth) async {
    CSMActEffect actEffect = await post('update', solution, auth: auth);
    return MainResolver<MigrationUpdateResult<YardLog>>(actEffect);
  }
}
      
